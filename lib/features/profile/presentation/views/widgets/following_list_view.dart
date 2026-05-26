import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/features/profile/data/models/followings_model.dart';
import 'package:sammly/features/profile/presentation/views/widgets/following_item_widget.dart';

class FollowingListView extends StatelessWidget {
  FollowingListView({super.key});

  final List<FollowingModel> _followingList = [
    FollowingModel(id: "1", name: "Fatma Salah", imageUrl: "https://i.pravatar.cc/150?img=5"),
    FollowingModel(id: "2", name: "Fatma Salah", imageUrl: "https://i.pravatar.cc/150?img=5"),
    FollowingModel(id: "3", name: "Fatma Salah", imageUrl: "https://i.pravatar.cc/150?img=5"),
    FollowingModel(id: "4", name: "Fatma Salah", imageUrl: "https://i.pravatar.cc/150?img=5"),
    FollowingModel(id: "5", name: "Fatma Salah", imageUrl: "https://i.pravatar.cc/150?img=5"),
    FollowingModel(id: "6", name: "Sama Ahmed", imageUrl: "https://i.pravatar.cc/150?img=9"),
    FollowingModel(id: "7", name: "Sama Ahmed", imageUrl: "https://i.pravatar.cc/150?img=9"),
    FollowingModel(id: "8", name: "Sama Ahmed", imageUrl: "https://i.pravatar.cc/150?img=9"),
    FollowingModel(id: "9", name: "Sama Ahmed", imageUrl: "https://i.pravatar.cc/150?img=9"),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 8.h, bottom: 20.h),
      itemCount: _followingList.length,
      itemBuilder: (context, index) {
        return FollowingItemWidget(
          item: _followingList[index],
          onUnfollowTap: () {
            // context.read<FollowingCubit>().unfollowUser(_followingList[index].id);
          },
        );
      },
    );
  }
}