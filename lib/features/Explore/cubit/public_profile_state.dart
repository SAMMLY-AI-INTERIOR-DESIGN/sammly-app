import 'package:sammly/features/Explore/data/public_profile_model.dart';

abstract class PublicProfileState {}

class PublicProfileInitial extends PublicProfileState {}

class PublicProfileLoading extends PublicProfileState {}

class PublicProfileSuccess extends PublicProfileState {
  final PublicProfileModel profileData;

  PublicProfileSuccess(this.profileData);
}

class PublicProfileFailure extends PublicProfileState {
  final String error;

  PublicProfileFailure(this.error);
}

// For pagination
class PublicProfilePaginationLoading extends PublicProfileSuccess {
  PublicProfilePaginationLoading(super.profileData);
}

class PublicProfilePaginationFailure extends PublicProfileSuccess {
  final String errorMsg;

  PublicProfilePaginationFailure(super.profileData, this.errorMsg);
}

class PublicProfileLikeSuccess extends PublicProfileSuccess {
  final String designId;
  final String message;

  PublicProfileLikeSuccess(super.profileData, this.designId, this.message);
}

class PublicProfileLikeError extends PublicProfileSuccess {
  final String error;

  PublicProfileLikeError(super.profileData, this.error);
}
