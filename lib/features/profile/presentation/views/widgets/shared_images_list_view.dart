import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/core/shared_pref/shared_pref.dart';
import 'package:sammly/features/Explore/cubit/design_details_cubit.dart';
import 'package:sammly/features/Explore/cubit/design_details_repo.dart';
import 'package:sammly/features/Explore/cubit/design_details_states.dart';
import 'package:sammly/features/profile/data/models/shared_images_model.dart';
import 'package:sammly/features/profile/presentation/views/widgets/shared_image_card.dart';
import 'package:sammly/features/History/presentation/views/historydetails.dart';

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
          create: (context) => DesignDetailsCubit(DesignDetailsRepo())..fetchDesignDetails(designId),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HistoryDetailsView(
                          title: item.title,
                          imageUrl: item.imageUrl,
                          designId: design.id,
                        ),
                      ),
                    );
                  },
                  child: SharedImageCard(item: item),
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
