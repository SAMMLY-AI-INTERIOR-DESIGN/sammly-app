import 'package:sammly/features/favorite/data/models/favorite_response_model.dart';

abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoading extends FavoriteState {}

/// Emitted when loading more pages (pagination).
class FavoritePaginationLoading extends FavoriteState {
  final List<FavoriteDesignModel> currentDesigns;
  final String selectedStyle;

  FavoritePaginationLoading({
    required this.currentDesigns,
    required this.selectedStyle,
  });
}

class FavoriteSuccess extends FavoriteState {
  final List<FavoriteDesignModel> designs;
  final String selectedStyle;
  final bool hasMore;

  FavoriteSuccess({
    required this.designs,
    required this.selectedStyle,
    required this.hasMore,
  });
}

class FavoriteEmpty extends FavoriteState {
  final String selectedStyle;

  FavoriteEmpty({required this.selectedStyle});
}

class FavoriteError extends FavoriteState {
  final String message;

  FavoriteError(this.message);
}