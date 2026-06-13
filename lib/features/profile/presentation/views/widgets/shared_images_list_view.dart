import 'package:flutter/material.dart';
import 'package:sammly/features/profile/data/models/shared_images_model.dart';
import 'package:sammly/features/profile/presentation/views/widgets/shared_image_card.dart';
import 'package:sammly/features/History/presentation/views/historydetails.dart';

class SharedImagesListView extends StatelessWidget {
  SharedImagesListView({super.key});

  final List<Map<String, dynamic>> sharedData = [
    {
      'imageUrl': 'https://images.unsplash.com/photo-1598928506311-c55ded91a20c?q=80&w=600&auto=format&fit=crop',
      'title': 'Modern Living Room',
      'likes': 34,
    },
    {
      'imageUrl': 'https://images.unsplash.com/photo-1616046229478-9901c5536a45?q=80&w=600&auto=format&fit=crop',
      'title': 'Minimalist Bedroom',
      'likes': 12,
    },
    {
      'imageUrl': 'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?q=80&w=600&auto=format&fit=crop',
      'title': 'Cozy Apartment',
      'likes': 8,
    },
    {
      'imageUrl': 'https://images.unsplash.com/photo-1617104678098-de229db51175?q=80&w=600&auto=format&fit=crop',
      'title': 'Elegant Kitchen',
      'likes': 45,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true, 
      physics: const NeverScrollableScrollPhysics(), 
      itemCount: sharedData.length, 
      itemBuilder: (context, index) {
        final data = sharedData[index];
        final item = SharedImageModel(
          title: data['title'],
          description: "Lorem ipsum dolor sit amet consectetur adipisicing elit",
          imageUrl: data['imageUrl'],
          likes: data['likes'],
        );

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HistoryDetailsView(
                  title: item.title,
                  imageUrl: item.imageUrl,
                  designId: 'dummy_id',
                ),
              ),
            );
          },
          child: SharedImageCard(
            item: item,
          ),
        );
      },
    );
  }
}
