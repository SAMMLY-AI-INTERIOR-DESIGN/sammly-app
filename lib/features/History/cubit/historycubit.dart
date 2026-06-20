import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sammly/features/History/cubit/history_state.dart';
import 'package:sammly/features/History/data/history_repo.dart';
import 'package:sammly/features/History/data/historymodel.dart';

class HistoryCubit extends Cubit<HistoryState> {

  @override
  void emit(HistoryState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }

  final HistoryRepo _repository;

  HistoryCubit(this._repository) : super(HistoryInitial());

  final List<HistoryDesignModel> _allDesigns = [];
  final Map<String, List<HistoryDesignModel>> _groupedDesigns = {};
  int _currentPage = 1;
  bool _hasMore = true;
  int _totalDesigns = 0;

  int get currentPage => _currentPage;
  bool get hasMore => _hasMore;
  int get totalDesigns => _totalDesigns;
  List<HistoryDesignModel> get currentDesigns => List.unmodifiable(_allDesigns);
  Map<String, List<HistoryDesignModel>> get groupedDesigns => _groupedDesigns;

  /// Resets all in-memory history state (used on logout).
  void reset() {
    _allDesigns.clear();
    _groupedDesigns.clear();
    _currentPage = 1;
    _hasMore = true;
    _totalDesigns = 0;
    emit(HistoryInitial());
  }

  void _processIncomingDesigns(List<HistoryDesignModel> newDesigns) {
    for (var design in newDesigns) {
      if (design.generationType == 'full_home' && design.groupId != null) {
        if (!_groupedDesigns.containsKey(design.groupId)) {
          _groupedDesigns[design.groupId!] = [];
          _allDesigns.add(design);
        }
        _groupedDesigns[design.groupId!]!.add(design);
      } else {
        _allDesigns.add(design);
      }
    }
  }

  /// Fetch the first page.
  Future<void> fetchHistory({int limit = 20}) async {
    _allDesigns.clear();
    _groupedDesigns.clear();
    _currentPage = 1;
    _hasMore = true;

    emit(HistoryLoading());

    final result = await _repository.getHistory(
      page: _currentPage,
      limit: limit,
    );

    result.fold((error) => emit(HistoryError(error)), (response) {
      _processIncomingDesigns(response.designs);
      _currentPage = response.page;
      _totalDesigns = response.totalDesigns;
      _hasMore = response.hasMore;

      emit(
        HistoryLoaded(
          designs: List.unmodifiable(_allDesigns),
          currentPage: _currentPage,
          totalDesigns: _totalDesigns,
          hasMore: _hasMore,
        ),
      );
    });
  }

  /// Load the next page and append results.
  Future<void> loadMore({int limit = 20}) async {
    if (!_hasMore) return;

    emit(HistoryPaginationLoading());

    final nextPage = _currentPage + 1;

    final result = await _repository.getHistory(page: nextPage, limit: limit);

    result.fold((error) => emit(HistoryError(error)), (response) {
      _processIncomingDesigns(response.designs);
      _currentPage = response.page;
      _totalDesigns = response.totalDesigns;
      _hasMore = response.hasMore;

      emit(
        HistoryLoaded(
          designs: List.unmodifiable(_allDesigns),
          currentPage: _currentPage,
          totalDesigns: _totalDesigns,
          hasMore: _hasMore,
        ),
      );
    });
  }
}
