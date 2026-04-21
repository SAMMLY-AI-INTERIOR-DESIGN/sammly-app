import 'package:flutter/material.dart';
import 'package:sammly/features/home/presentation/views/widgets/ai_banner_widget.dart';
import 'package:sammly/features/home/presentation/views/widgets/explore_styles_section.dart';
import 'package:sammly/features/home/presentation/views/widgets/home_header.dart';
import 'package:sammly/features/home/presentation/views/widgets/search_bar_widget.dart';



class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              HomeHeader(),
              SizedBox(height: 16),
              SearchBarWidget(),
              SizedBox(height: 24),
              AIBannerWidget(),
              SizedBox(height: 24),
              ExploreStylesSection(),
              SizedBox(height: 100), 
            ],
          ),
        ),
      ),
    );
  }
}
