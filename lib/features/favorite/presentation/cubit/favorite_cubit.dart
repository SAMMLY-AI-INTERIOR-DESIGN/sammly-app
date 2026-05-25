import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sammly/features/favorite/presentation/cubit/favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial());

  
}