import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sammly/features/following/data/repo/following_repo.dart';
import 'package:sammly/features/following/cubit/following_states.dart';
import 'package:sammly/features/following/data/model/following_model.dart';

class FollowingCubit extends Cubit<FollowingState> {
  final FollowingRepo _repo;
  FollowingCubit(this._repo) : super(FollowingInitial());

  static FollowingCubit get(context) => BlocProvider.of(context);

  List<FollowingModel> followings = [];
  int _currentPage = 1;
  bool _hasMore = true;

  Future<void> getFollowings({bool loadMore = false}) async {
    if (!loadMore) {
      if (isClosed) return;
      emit(GetFollowingsLoading());
      _currentPage = 1;
      followings.clear();
      _hasMore = true;
    } else {
      if (!_hasMore) return;
    }

    final result = await _repo.getFollowings(page: _currentPage);
    if (isClosed) return;
    result.fold((error) => emit(GetFollowingsFailure(error)), (response) {
      if (!loadMore) {
        followings = response.profiles;
      } else {
        followings.addAll(response.profiles);
      }
      _currentPage++;
      _hasMore = response.hasMore;
      if (isClosed) return;
      emit(GetFollowingsSuccess(response));
    });
  }

  Future<void> followUser(String userId) async {
    if (isClosed) return;
    emit(FollowLoading(userId));
    final result = await _repo.followUser(userId);
    if (isClosed) return;
    result.fold((error) => emit(FollowFailure(error, userId)), (message) {
      emit(FollowSuccess(message, userId));
    });
  }

  Future<void> unfollowUser(String userId) async {
    if (isClosed) return;
    emit(UnfollowLoading(userId));
    final result = await _repo.unfollowUser(userId);
    if (isClosed) return;
    result.fold((error) => emit(UnfollowFailure(error, userId)), (message) {
      emit(UnfollowSuccess(message, userId));
    });
  }
}
