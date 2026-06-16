import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sammly/features/Explore/cubit/explorestates.dart';
import 'package:sammly/features/Explore/cubit/explorerepo.dart';
import 'package:sammly/features/Explore/data/exploremodel.dart';

class ExploreCubit extends Cubit<ExploreState> {
  final ExploreRepo _repository;

  ExploreCubit(this._repository) : super(ExploreInitial());

  final List<ExploreDesignModel> _allDesigns = [];
  int _currentPage = 1;
  bool _hasMore = true;

  String _currentSort = 'latest';
  String? _currentSearch;

  int get currentPage => _currentPage;
  bool get hasMore => _hasMore;
  String get currentSort => _currentSort;
  String? get currentSearch => _currentSearch;
  List<ExploreDesignModel> get currentDesigns => List.unmodifiable(_allDesigns);

  /// Resets all in-memory explore state (used on logout).
  void reset() {
    _allDesigns.clear();
    _currentPage = 1;
    _hasMore = true;
    _currentSort = 'latest';
    _currentSearch = null;
    emit(ExploreInitial());
  }

  /// Fetch the first page.
  Future<void> fetchExplore({
    int limit = 20,
    String sort = 'latest',
    String? search,
  }) async {
    _allDesigns.clear();
    _currentPage = 1;
    _hasMore = true;
    _currentSort = sort;
    _currentSearch = search;

    emit(ExploreLoading());

    final result = await _repository.getSharedDesigns(
      page: _currentPage,
      limit: limit,
      sort: _currentSort,
      search: _currentSearch,
    );

    result.fold((error) => emit(ExploreError(error)), (response) {
      _allDesigns.addAll(response.designs);
      _currentPage = response.page;
      _hasMore = response.hasMore;

      emit(
        ExploreLoaded(
          designs: List.unmodifiable(_allDesigns),
          currentPage: _currentPage,
          hasMore: _hasMore,
        ),
      );
    });
  }

  /// Load the next page and append results.
  Future<void> loadMore({int limit = 20}) async {
    if (!_hasMore) return;

    emit(ExplorePaginationLoading());

    final nextPage = _currentPage + 1;

    final result = await _repository.getSharedDesigns(
      page: nextPage,
      limit: limit,
      sort: _currentSort,
      search: _currentSearch,
    );

    result.fold((error) => emit(ExploreError(error)), (response) {
      _allDesigns.addAll(response.designs);
      _currentPage = response.page;
      _hasMore = response.hasMore;

      emit(
        ExploreLoaded(
          designs: List.unmodifiable(_allDesigns),
          currentPage: _currentPage,
          hasMore: _hasMore,
        ),
      );
    });
  }

  /// Change sort and re-fetch from page 1.
  Future<void> changeSort(String sort, {int limit = 20}) async {
    await fetchExplore(sort: sort, search: _currentSearch, limit: limit);
  }

  /// Search designs and re-fetch from page 1.
  Future<void> searchDesigns(String? query, {int limit = 20}) async {
    await fetchExplore(sort: _currentSort, search: query, limit: limit);
  }

  /// Toggle like locally (optimistic update).
  void toggleLikeLocal(String designId) {
    final index = _allDesigns.indexWhere((d) => d.id == designId);
    if (index == -1) return;

    final design = _allDesigns[index];
    _allDesigns[index] = design.copyWith(
      isLiked: !design.isLiked,
      likesCount: design.isLiked
          ? design.likesCount - 1
          : design.likesCount + 1,
    );

    emit(
      ExploreLoaded(
        designs: List.unmodifiable(_allDesigns),
        currentPage: _currentPage,
        hasMore: _hasMore,
      ),
    );
  }

  /// Toggle favorite locally (optimistic update).
  void toggleFavoriteLocal(String designId) {
    final index = _allDesigns.indexWhere((d) => d.id == designId);
    if (index == -1) return;

    final design = _allDesigns[index];
    _allDesigns[index] = design.copyWith(
      isFavorited: !design.isFavorited,
    );

    emit(
      ExploreLoaded(
        designs: List.unmodifiable(_allDesigns),
        currentPage: _currentPage,
        hasMore: _hasMore,
      ),
    );
  }
}
