import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sammly/features/Explore/cubit/public_profile_state.dart';
import 'package:sammly/features/Explore/data/public_profile_model.dart';
import 'package:sammly/features/Explore/cubit/public_profile_repo.dart';
import 'package:sammly/features/Explore/cubit/design_details_repo.dart';

class PublicProfileCubit extends Cubit<PublicProfileState> {

  @override
  void emit(PublicProfileState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }

  final PublicProfileRepo publicProfileRepo;
  
  PublicProfileCubit(this.publicProfileRepo) : super(PublicProfileInitial());

  PublicProfileModel? currentData;
  int currentPage = 1;

  Future<void> getPublicProfile({required String userId, bool loadMore = false}) async {
    if (loadMore) {
      if (currentData == null || !currentData!.pagination.hasMore) return;
      currentPage++;
      emit(PublicProfilePaginationLoading(currentData!));
    } else {
      currentPage = 1;
      emit(PublicProfileLoading());
    }

    final result = await publicProfileRepo.getPublicProfile(
      userId: userId,
      page: currentPage,
      limit: 20,
    );

    result.fold(
      (failure) {
        if (loadMore) {
          currentPage--;
          emit(PublicProfilePaginationFailure(currentData!, failure));
        } else {
          emit(PublicProfileFailure(failure));
        }
      },
      (data) {
        if (loadMore && currentData != null) {
          currentData = PublicProfileModel(
            profile: data.profile,
            isFollowing: data.isFollowing,
            stats: data.stats,
            pagination: data.pagination,
            designs: [...currentData!.designs, ...data.designs],
          );
        } else {
          currentData = data;
        }
        emit(PublicProfileSuccess(currentData!));
      },
    );
  }
  
  void updateFollowStatus(bool isFollowing) {
    if (currentData != null) {
      currentData = PublicProfileModel(
        profile: currentData!.profile,
        isFollowing: isFollowing,
        stats: currentData!.stats,
        pagination: currentData!.pagination,
        designs: currentData!.designs,
      );
      emit(PublicProfileSuccess(currentData!));
    }
  }

  Future<void> toggleLike(String designId, bool isLiked) async {
    if (currentData != null) {
      final originalData = currentData!;
      int totalLikesDiff = isLiked ? 1 : -1;
      
      final updatedDesigns = currentData!.designs.map((d) {
        if (d.id == designId) {
          return d.copyWith(
            isLiked: isLiked,
            likesCount: d.likesCount + totalLikesDiff,
          );
        }
        return d;
      }).toList();

      final updatedStats = ProfileStats(
        totalDesigns: currentData!.stats.totalDesigns,
        totalLikes: currentData!.stats.totalLikes + totalLikesDiff,
      );

      currentData = PublicProfileModel(
        profile: currentData!.profile,
        isFollowing: currentData!.isFollowing,
        stats: updatedStats,
        pagination: currentData!.pagination,
        designs: updatedDesigns,
      );

      emit(PublicProfileSuccess(currentData!));

      final repo = DesignDetailsRepo();
      final result = isLiked
          ? await repo.likeDesign(designId)
          : await repo.unlikeDesign(designId);

      result.fold(
        (failure) {
          currentData = originalData;
          emit(PublicProfileLikeError(currentData!, failure));
        },
        (message) {
          emit(PublicProfileLikeSuccess(currentData!, designId, message));
        },
      );
    }
  }
}
