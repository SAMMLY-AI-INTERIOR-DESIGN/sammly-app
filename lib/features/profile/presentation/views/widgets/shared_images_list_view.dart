import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/core/shared_pref/shared_pref.dart';
import 'package:sammly/features/Explore/cubit/design_details_cubit.dart';
import 'package:sammly/features/Explore/cubit/design_details_repo.dart';
import 'package:sammly/features/Explore/cubit/design_details_states.dart';
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
          child: BlocBuilder<DesignDetailsCubit, DesignDetailsState>(
            builder: (context, state) {
              if (state is DesignDetailsLoaded) {
                final design = state.design;
                final title = '${design.style} design'.trim();

                _updateLikes(design.id, design.likesCount);

                final item = SharedImageModel(
                  title: title.isEmpty ? 'Unknown Design' : title,
                  description: design.prompt,
                  imageUrl: design.imageUrl,
                  likes: design.likesCount,
                );

                return GestureDetector(
                  onTap: () {
                    final profile = context.read<ProfileCubit>().currentProfile;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SharedDesignDetailsView(
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
                    );
                  },
                  child: SharedImageCard(
                    item: item,
                    readOnly: true,
                  ),
                );
              } else if (state is DesignDetailsError) {
                return const SizedBox.shrink();
              } else {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 250.h),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
            },
          ),
        );
      },
    );
  }
}
