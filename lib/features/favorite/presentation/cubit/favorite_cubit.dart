import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sammly/core/constant/app_strings.dart';
import 'package:sammly/features/favorite/data/models/favorite_response_model.dart';
import 'package:sammly/features/favorite/data/repo/favorite_repo.dart';
import 'package:sammly/features/favorite/presentation/cubit/favorite_state.dart';
import 'package:sammly/features/generate/data/model/generate_mappers.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final FavoriteRepo favoriteRepo;

  FavoriteCubit(this.favoriteRepo) : super(FavoriteInitial());

  // ── Pagination State ──
  int _currentPage = 1;
  bool _hasMore = false;
  bool _isFetching = false;
  String _selectedStyle = AppStrings.all;
  final List<FavoriteDesignModel> _allDesigns = [];

  static const int _pageLimit = 20;

  String get selectedStyle => _selectedStyle;

  @override
  void emit(FavoriteState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }

  /// Fetches the first page of favorites (resets pagination).
  /// Called on initial load and when the style filter changes.
  Future<void> getFavorites({String? style}) async {
    if (style != null) _selectedStyle = style;

    _currentPage = 1;
    _hasMore = false;
    _allDesigns.clear();
    _isFetching = true;

    emit(FavoriteLoading());

    final apiStyle = _mapStyleToApi(_selectedStyle);

    final result = await favoriteRepo.getFavorites(
      page: _currentPage,
      limit: _pageLimit,
      style: apiStyle,
    );

    _isFetching = false;

    result.fold(
      (error) => emit(FavoriteError(error)),
      (response) {
        _hasMore = response.pagination.hasMore;
        _allDesigns.addAll(response.designs);

        if (_allDesigns.isEmpty) {
          emit(FavoriteEmpty(selectedStyle: _selectedStyle));
        } else {
          emit(FavoriteSuccess(
            designs: List.unmodifiable(_allDesigns),
            selectedStyle: _selectedStyle,
            hasMore: _hasMore,
          ));
        }
      },
    );
  }

  /// Loads the next page of favorites (pagination).
  Future<void> loadMoreFavorites() async {
    if (_isFetching || !_hasMore) return;

    _isFetching = true;
    _currentPage++;

    emit(FavoritePaginationLoading(
      currentDesigns: List.unmodifiable(_allDesigns),
      selectedStyle: _selectedStyle,
    ));

    final apiStyle = _mapStyleToApi(_selectedStyle);

    final result = await favoriteRepo.getFavorites(
      page: _currentPage,
      limit: _pageLimit,
      style: apiStyle,
    );

    _isFetching = false;

    result.fold(
      (error) {
        _currentPage--; // Revert page increment on failure
        emit(FavoriteSuccess(
          designs: List.unmodifiable(_allDesigns),
          selectedStyle: _selectedStyle,
          hasMore: _hasMore,
        ));
      },
      (response) {
        _hasMore = response.pagination.hasMore;
        _allDesigns.addAll(response.designs);

        emit(FavoriteSuccess(
          designs: List.unmodifiable(_allDesigns),
          selectedStyle: _selectedStyle,
          hasMore: _hasMore,
        ));
      },
    );
  }

  /// Maps UI style display value to the API query value.
  /// "All" maps to "all", others use GenerateMappers.
  String _mapStyleToApi(String uiStyle) {
    if (uiStyle == AppStrings.all) return 'all';
    return GenerateMappers.styleToApi(uiStyle);
  }
}