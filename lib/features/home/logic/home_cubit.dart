import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sammly/features/home/data/models/home_model.dart';
import 'package:sammly/features/home/data/repo/home_repo.dart';
import 'package:sammly/features/home/logic/home_state.dart';

class HomeCubit extends Cubit<HomeState> {

  @override
  void emit(HomeState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }

  final HomeRepo _repository;
  HomeModel? currentHome;

  HomeCubit(this._repository) : super(HomeInitial());

  /// Resets all in-memory home state (used on logout).
  void reset() {
    currentHome = null;
    emit(HomeInitial());
  }

  Future<void> fetchHomeData() async {
    emit(HomeLoading());

    final result = await _repository.getHomeData();

    result.fold((error) => emit(HomeError(error)), (homeData) {
      currentHome = homeData;
      emit(HomeLoaded(homeData));
    });
  }
}
