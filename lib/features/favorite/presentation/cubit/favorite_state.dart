import 'package:sammly/features/favorite/data/models/favorite_item_model.dart';

abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class FavoritePaginationLoading extends FavoriteState {}

class FavoriteLoaded extends FavoriteState {
  final List<FavoriteModel> favorites;
  final String selectedRoom;
  final int currentPage;
  final bool hasMore;

  FavoriteLoaded({
    required this.favorites,
    required this.selectedRoom,
    required this.currentPage,
    required this.hasMore,
  });
}

class FavoriteError extends FavoriteState {
  final String message;
  FavoriteError(this.message);
}

class FavoriteToggleSuccess extends FavoriteState {
  final String message;
  FavoriteToggleSuccess(this.message);
}

class FavoriteToggleError extends FavoriteState {
  final String message;
  FavoriteToggleError(this.message);
}