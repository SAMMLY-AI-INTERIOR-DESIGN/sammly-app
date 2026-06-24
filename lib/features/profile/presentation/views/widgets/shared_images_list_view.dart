import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/shared_pref/shared_pref.dart';
import 'package:sammly/features/Explore/cubit/design_details_cubit.dart';
import 'package:sammly/features/Explore/cubit/design_details_repo.dart';
import 'package:sammly/features/Explore/cubit/design_details_states.dart';
import 'package:sammly/features/Explore/cubit/explorecubit.dart';
import 'package:sammly/features/Explore/data/exploremodel.dart';
import 'package:sammly/features/Explore/presentation/views/shared_design_details_view.dart';
import 'package:sammly/features/profile/data/models/shared_images_model.dart';
import 'package:sammly/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:sammly/features/profile/presentation/views/widgets/shared_image_card.dart';

class SharedImagesListView extends StatefulWidget {
  final Function(int postsCount, int likesCount)? onDataCalculated;
  const SharedImagesListView({super.key, this.onDataCalculated});

  @override
  State<SharedImagesListView> createState() => _SharedImagesListViewState();
}

class _SharedImagesListViewState extends State<SharedImagesListView> {
  List<String> _sharedIds = [];
  final Map<String, int> _likesMap = {};

  @override
  void initState() {
    super.initState();
    _loadSharedIds();
  }

  void _loadSharedIds() {
    final idsStr = SharedPref.getData(key: 'shared_design_ids') ?? '';
    if (idsStr.isNotEmpty) {
      _sharedIds = idsStr.split(',').where((e) => e.isNotEmpty).toList();
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onDataCalculated?.call(_sharedIds.length, 0);
    });
  }

  void _updateLikes(String id, int likes) {
    if (_likesMap[id] != likes) {
      _likesMap[id] = likes;
      final totalLikes = _likesMap.values.fold(0, (a, b) => a + b);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.onDataCalculated?.call(_sharedIds.length, totalLikes);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_sharedIds.isEmpty) {
      return const SizedBox.shrink();
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _sharedIds.length,
      itemBuilder: (context, index) {
        final designId = _sharedIds[index];

        return BlocProvider(
          create: (context) =>
              DesignDetailsCubit(DesignDetailsRepo())
                ..fetchDesignDetails(designId),
          child: BlocConsumer<DesignDetailsCubit, DesignDetailsState>(
            listener: (context, state) {
              if (state is DesignLikeSuccess) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: AppColors.primaryColor,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                context.read<ExploreCubit>().toggleLikeLocal(designId);
              } else if (state is DesignUnlikeSuccess) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: AppColors.primaryColor,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                context.read<ExploreCubit>().toggleLikeLocal(designId);
              } else if (state is DesignActionError) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
              }
            },
            builder: (context, state) {
              final cubit = context.read<DesignDetailsCubit>();
              final design = cubit.currentDesign;

              if (state is DesignDetailsLoading && design == null) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: const Center(child: CircularProgressIndicator()),
                );
              }

              if (state is DesignDetailsLoading && design != null) {
                return Container(
                  width: 366.w,
                  height: 135.h,
                  margin: EdgeInsetsDirectional.only(bottom: 12.h),
                  decoration: BoxDecoration(
                    color: AppColors.bg2Color,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  ),
                );
              }

              if (design != null) {
                final title = '${design.style} design'.trim();

                _updateLikes(design.id, design.likesCount);

                final item = SharedImageModel(
                  title: title.isEmpty ? 'Unknown Design' : title,
                  description: design.prompt,
                  imageUrl: design.imageUrl,
                  likes: design.likesCount,
                  isLiked: design.isLiked,
                );

                return GestureDetector(
                  onTap: () {
                    final profile = context.read<ProfileCubit>().currentProfile;
                    final existingCubit = context.read<DesignDetailsCubit>();
                    
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider.value(
                          value: existingCubit,
                          child: SharedDesignDetailsView(
                            exploreDesign: ExploreDesignModel(
                              id: design.id,
                              name: profile?.name ?? '',
                              avatar: profile?.avatar ?? '',
                              likesCount: design.likesCount,
                              prompt: design.prompt,
                              imageUrl: design.imageUrl,
                              sharedAt: design.sharedAt ?? '',
                              isLiked: design.isLiked,
                              isFavorited: design.isFavorited,
                              style: design.style,
                              room: design.room,
                            ),
                          ),
                        ),
                      ),
                    ).then((_) {
                      if (context.mounted) {
                        existingCubit.fetchDesignDetails(design.id);
                      }
                    });
                  },
                  child: SharedImageCard(
                    item: item,
                    readOnly: false,
                    onLikeChanged: (isLiked) {
                      cubit.toggleLike(design.id);
                    },
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        );
      },
    );
  }
}
