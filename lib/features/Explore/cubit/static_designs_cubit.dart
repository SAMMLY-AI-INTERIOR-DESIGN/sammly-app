import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sammly/features/Explore/cubit/static_designs_states.dart';
import 'package:sammly/features/Explore/cubit/static_designs_repo.dart';
import 'package:sammly/features/Explore/data/static_design_model.dart';

class StaticDesignsCubit extends Cubit<StaticDesignsState> {
  final StaticDesignsRepo _repository;

  StaticDesignsCubit(this._repository) : super(StaticDesignsInitial());

  final List<StaticDesignModel> _allDesigns = [];
  int _currentPage = 1;
  bool _hasMore = true;

  String? _currentRoom;
  String _currentStyle = 'all';

  int get currentPage => _currentPage;
  bool get hasMore => _hasMore;
  String? get currentRoom => _currentRoom;
  String get currentStyle => _currentStyle;
  List<StaticDesignModel> get currentDesigns => List.unmodifiable(_allDesigns);

  /// Fetch the first page (resets everything).
  Future<void> fetchStaticDesigns({
    int limit = 20,
    String? room,
    String style = 'all',
  }) async {
    _allDesigns.clear();
    _currentPage = 1;
    _hasMore = true;
    _currentRoom = room;
    _currentStyle = style;

    emit(StaticDesignsLoading());

    final result = await _repository.getStaticDesigns(
      page: _currentPage,
      limit: limit,
      room: _currentRoom,
      style: _currentStyle,
    );

    result.fold(
      (error) => emit(StaticDesignsError(error)),
      (response) {
        _allDesigns.addAll(response.designs);
        _currentPage = response.page;
        _hasMore = response.hasMore;

        emit(StaticDesignsLoaded(
          designs: List.unmodifiable(_allDesigns),
          currentPage: _currentPage,
          hasMore: _hasMore,
        ));
      },
    );
  }

  /// Load the next page and append results.
  Future<void> loadMore({int limit = 20}) async {
    if (!_hasMore) return;

    emit(StaticDesignsPaginationLoading());

    final nextPage = _currentPage + 1;

    final result = await _repository.getStaticDesigns(
      page: nextPage,
      limit: limit,
      room: _currentRoom,
      style: _currentStyle,
    );

    result.fold(
      (error) => emit(StaticDesignsError(error)),
      (response) {
        _allDesigns.addAll(response.designs);
        _currentPage = response.page;
        _hasMore = response.hasMore;

        emit(StaticDesignsLoaded(
          designs: List.unmodifiable(_allDesigns),
          currentPage: _currentPage,
          hasMore: _hasMore,
        ));
      },
    );
  }

  /// Change room filter and re-fetch from page 1.
  Future<void> changeRoom(String? room, {int limit = 20}) async {
    await fetchStaticDesigns(room: room, style: _currentStyle, limit: limit);
  }

  /// Change style filter and re-fetch from page 1.
  Future<void> changeStyle(String style, {int limit = 20}) async {
    await fetchStaticDesigns(room: _currentRoom, style: style, limit: limit);
  }

  /// Change both room and style filters and re-fetch from page 1.
  Future<void> changeFilters({
    String? room,
    String style = 'all',
    int limit = 20,
  }) async {
    await fetchStaticDesigns(room: room, style: style, limit: limit);
  }

  /// Toggle favorite locally (optimistic update).
  void toggleFavoriteLocal(String designId) {
    final index = _allDesigns.indexWhere((d) => d.id == designId);
    if (index == -1) return;

    final design = _allDesigns[index];
    _allDesigns[index] = design.copyWith(
      isFavorited: !design.isFavorited,
    );

    emit(StaticDesignsLoaded(
      designs: List.unmodifiable(_allDesigns),
      currentPage: _currentPage,
      hasMore: _hasMore,
    ));
  }
}
