import 'package:sammly/features/following/data/model/following_model.dart';

abstract class FollowingState {}

class FollowingInitial extends FollowingState {}

// Get Followings
class GetFollowingsLoading extends FollowingState {}

class GetFollowingsSuccess extends FollowingState {
  final FollowingResponse response;
  GetFollowingsSuccess(this.response);
}

class GetFollowingsFailure extends FollowingState {
  final String error;
  GetFollowingsFailure(this.error);
}

// Follow
class FollowLoading extends FollowingState {
  final String userId;
  FollowLoading(this.userId);
}

class FollowSuccess extends FollowingState {
  final String message;
  final String userId;
  FollowSuccess(this.message, this.userId);
}

class FollowFailure extends FollowingState {
  final String error;
  final String userId;
  FollowFailure(this.error, this.userId);
}

// Unfollow
class UnfollowLoading extends FollowingState {
  final String userId;
  UnfollowLoading(this.userId);
}

class UnfollowSuccess extends FollowingState {
  final String message;
  final String userId;
  UnfollowSuccess(this.message, this.userId);
}

class UnfollowFailure extends FollowingState {
  final String error;
  final String userId;
  UnfollowFailure(this.error, this.userId);
}
