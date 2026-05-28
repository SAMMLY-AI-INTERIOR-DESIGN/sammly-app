import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sammly/features/layout/presentation/cubit/layout_cubit/layout_cubit.dart';
import 'package:sammly/features/layout/presentation/cubit/layout_cubit/layout_state.dart';
import 'package:sammly/features/layout/presentation/views/widgets/custom_bottom_nav_bar.dart';
import 'package:move_to_bg/move_to_bg.dart';

class LayoutView extends StatelessWidget {
  const LayoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LayoutCubit(),
      child: BlocBuilder<LayoutCubit, LayoutState>(
        builder: (context, state) {
          var cubit = context.read<LayoutCubit>();
          return PopScope(
            canPop: false,
            onPopInvokedWithResult: (didPop, result) {
              if (didPop) return;
              if (cubit.currentIndex != 0) {
                cubit.changeIndex(0);
              } else {
                MoveToBg().moveTaskToBack();
              }
            },
            child: Scaffold(
              extendBody: true,
              body: cubit.views[cubit.currentIndex],
              bottomNavigationBar: CustomBottomNavBar(
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
