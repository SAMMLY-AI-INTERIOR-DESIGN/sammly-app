import 'package:sammly/features/favorite/data/models/favorite_item_model.dart';

abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class FavoriteSuccess extends FavoriteState {
  final List<FavoriteModel> favorites;
  final String selectedCategory;

  FavoriteSuccess({required this.favorites, required this.selectedCategory});
}

class FavoriteEmpty extends FavoriteState {}

class FavoriteError extends FavoriteState {
  final String message;
  FavoriteError(this.message);
}