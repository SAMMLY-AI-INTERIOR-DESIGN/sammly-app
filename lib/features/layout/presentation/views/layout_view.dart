import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sammly/features/layout/presentation/cubit/layout_cubit/layout_cubit.dart';
import 'package:sammly/features/layout/presentation/cubit/layout_cubit/layout_state.dart';
import 'package:sammly/features/layout/presentation/views/widgets/custom_bottom_nav_bar.dart';



class LayoutView extends StatelessWidget {
  const LayoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LayoutCubit(),
      child: BlocBuilder<LayoutCubit, LayoutState>(
        builder: (context, state) {
          var cubit = context.read<LayoutCubit>();
          return Scaffold(
            extendBody: true,
            body: cubit.views[cubit.currentIndex],
            bottomNavigationBar: SafeArea(
              child: CustomBottomNavBar(
                currentIndex: cubit.currentIndex,
                onTap: (index) {
                  cubit.changeIndex(index);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
