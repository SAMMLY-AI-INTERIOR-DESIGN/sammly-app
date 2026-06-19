import 'package:sammly/features/profile/data/models/profile_model.dart';
import 'package:sammly/features/profile/data/models/setting_info_model.dart';

abstract class ProfileState {}

class ProfileUnreadNotificationsUpdated extends ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final ProfileModel profile;

  ProfileLoaded(this.profile);
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);
}

// Edit Profile States
class EditProfileLoading extends ProfileState {}

class EditProfileSuccess extends ProfileState {
  final ProfileModel profile;

  EditProfileSuccess(this.profile);
}

class EditProfileError extends ProfileState {
  final String message;

  EditProfileError(this.message);
}

// Setting Info States
class SettingInfoLoading extends ProfileState {}

class SettingInfoLoaded extends ProfileState {
  final SettingInfoModel settingInfo;

  SettingInfoLoaded(this.settingInfo);
}

class SettingInfoError extends ProfileState {
  final String message;

  SettingInfoError(this.message);
}
