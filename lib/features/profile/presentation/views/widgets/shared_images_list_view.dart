import 'package:flutter/material.dart';
import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/features/profile/data/models/shared_images_model.dart';
import 'package:sammly/features/profile/presentation/views/widgets/shared_image_card.dart';

class SharedImagesListView extends StatelessWidget {
  SharedImagesListView({super.key});

  final List<SharedImageModel> sharedImages = List.generate(
    5,
    (index) => SharedImageModel(
      title: "Wooden Sideboard Table",
      description: "Wooden Sideboard Table Wooden Sideboard Table",
      imageUrl: AppImages.profilePlaceholder,
      likes: 34,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true, 
      physics: const NeverScrollableScrollPhysics(), 
      itemCount: 5, 
      itemBuilder: (context, index) {
        return SharedImageCard(
          item: sharedImages[index],
        );
      },
    );
  }
}
