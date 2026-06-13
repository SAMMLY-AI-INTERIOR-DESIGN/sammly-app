import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/core/constant/app_strings.dart';
import 'package:sammly/core/functions.dart';
import 'package:sammly/core/widgets/no_data_widget.dart';
import 'package:sammly/features/following/cubit/following_cubit.dart';
import 'package:sammly/features/following/cubit/following_states.dart';
import 'package:sammly/features/following/presentation/widgets/following_item_widget.dart';

class FollowingListView extends StatefulWidget {
  const FollowingListView({super.key});

  @override
  State<FollowingListView> createState() => _FollowingListViewState();
}

class _FollowingListViewState extends State<FollowingListView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<FollowingCubit>().getFollowings();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<FollowingCubit>().getFollowings(loadMore: true);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FollowingCubit, FollowingState>(
      listener: (context, state) {
        if (state is UnfollowSuccess) {
          showCustomSnackBar(context: context, message: state.message);
        } else if (state is UnfollowFailure) {
          showCustomSnackBar(
            context: context,
            message: state.error,
            isError: true,
          );
        } else if (state is FollowSuccess) {
          showCustomSnackBar(context: context, message: state.message);
        } else if (state is FollowFailure) {
          showCustomSnackBar(
            context: context,
            message: state.error,
            isError: true,
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<FollowingCubit>();

        if (state is GetFollowingsLoading && cubit.followings.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (cubit.followings.isEmpty) {
          return const NoDataWidget(
            image: AppImages.noFollowing,
            title: AppStrings.noFollowings,
            description: AppStrings.noFollowingsDesc,
          );
        }

        return ListView.builder(
          controller: _scrollController,
          padding: EdgeInsets.only(top: 8.h, bottom: 20.h),
          itemCount:
              cubit.followings.length + (state is GetFollowingsLoading ? 1 : 0),
          itemBuilder: (context, index) {
            if (index >= cubit.followings.length) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                ),
              );
            }

            final item = cubit.followings[index];
            return FollowingItemWidget(
              item: item,
              onUnfollowTap: () {
                cubit.unfollowUser(item.id);
              },
              onFollowTap: () {
                cubit.followUser(item.id);
              },
            );
          },
        );
      },
    );
  }
}
