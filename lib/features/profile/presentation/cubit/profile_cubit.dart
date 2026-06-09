import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sammly/features/profile/data/models/profile_model.dart';
import 'package:sammly/features/profile/data/repo/profile_repo.dart';
import 'package:sammly/features/profile/presentation/cubit/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo _repository;
  ProfileModel? currentProfile;

  ProfileCubit(this._repository) : super(ProfileInitial());

  Future<void> fetchProfile({bool forceRefresh = false}) async {
    if (currentProfile == null || forceRefresh) {
      emit(ProfileLoading());
    }

    final result = await _repository.getProfile(forceRefresh: forceRefresh);

    result.fold(
      (error) => emit(ProfileError(error)),
      (profile) {
        currentProfile = profile;
        emit(ProfileLoaded(profile));
      },
    );
  }

  Future<void> editProfile(Map<String, dynamic> data, {File? imageFile}) async {
    emit(EditProfileLoading());

    final result = await _repository.editProfile(data, imageFile: imageFile);

    result.fold(
      (error) => emit(EditProfileError(error)),
      (profile) {
        currentProfile = profile;
        emit(EditProfileSuccess(profile));
        emit(ProfileLoaded(profile));
      },
    );
  }
}
