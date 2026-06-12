// This cubit tracks which design IDs are favorited
// and emits state changes for optimistic UI updates.
// States for the global favorite toggle cubit.

abstract class FavoriteToggleState {}

class FavoriteToggleInitial extends FavoriteToggleState {}

/// Emitted when a design's favorite status changes optimistically.
class FavoriteToggleUpdated extends FavoriteToggleState {
  /// The design ID that was toggled.
  final String designId;

  /// Current favorite status after the toggle.
  final bool isFavorited;

  FavoriteToggleUpdated({
    required this.designId,
    required this.isFavorited,
  });
}

/// Emitted when the API call failed and the toggle was reverted.
class FavoriteToggleReverted extends FavoriteToggleState {
  final String designId;
  final bool isFavorited;
  final String errorMessage;

  FavoriteToggleReverted({
    required this.designId,
    required this.isFavorited,
    required this.errorMessage,
  });
}
