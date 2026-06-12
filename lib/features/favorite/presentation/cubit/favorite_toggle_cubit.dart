import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sammly/features/favorite/data/repo/favorite_repo.dart';
import 'package:sammly/features/favorite/presentation/cubit/favorite_toggle_state.dart';

/// Global cubit that manages add/remove favorite with Optimistic UI.
///
/// Provided at the app level so all screens share the same instance
/// and can react to favorite toggles from any screen.
class FavoriteToggleCubit extends Cubit<FavoriteToggleState> {
  final FavoriteRepo favoriteRepo;

  FavoriteToggleCubit(this.favoriteRepo) : super(FavoriteToggleInitial());

  /// Tracks the current favorite status for each design by ID.
  final Map<String, bool> _favoriteMap = {};

  @override
  void emit(FavoriteToggleState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }

  /// Returns whether a design is currently favorited.
  bool isFavorited(String designId) => _favoriteMap[designId] ?? false;

  /// Seeds the initial favorite status for a design (e.g. from API data).
  void seedFavoriteStatus(String designId, bool isFavorited) {
    _favoriteMap[designId] = isFavorited;
  }

  /// Seeds multiple design IDs as favorited at once.
  void seedFavoritedIds(Set<String> ids) {
    for (final id in ids) {
      _favoriteMap[id] = true;
    }
  }

  /// Toggles the favorite status with Optimistic UI:
  /// 1. Flip the state instantly in the UI.
  /// 2. Call the API in the background.
  /// 3. On failure → revert + emit error state.
  Future<void> toggleFavorite(String designId) async {
    final wasFavorited = _favoriteMap[designId] ?? false;
    final newFavorited = !wasFavorited;

    // ── Step 1: Optimistic update ──
    _favoriteMap[designId] = newFavorited;
    emit(FavoriteToggleUpdated(
      designId: designId,
      isFavorited: newFavorited,
    ));

    // ── Step 2: API call in background ──
    final result = newFavorited
        ? await favoriteRepo.addToFavorites(designId)
        : await favoriteRepo.removeFromFavorites(designId);

    // ── Step 3: Handle failure → revert ──
    result.fold(
      (error) {
        _favoriteMap[designId] = wasFavorited;
        emit(FavoriteToggleReverted(
          designId: designId,
          isFavorited: wasFavorited,
          errorMessage: error,
        ));
      },
      (_) {
        // Success — nothing to do, optimistic state is already correct
      },
    );
  }
}
