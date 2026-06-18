import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sammly/features/Explore/presentation/views/exploreview.dart';
import 'package:sammly/features/History/presentation/views/historyview.dart';
import 'package:sammly/features/home/presentation/views/home_view.dart';
import 'package:sammly/features/layout/presentation/cubit/layout_cubit/layout_state.dart';
import 'package:sammly/features/profile/presentation/views/profile_view.dart';

class LayoutCubit extends Cubit<LayoutState> {

  @override
  void emit(LayoutState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }

  LayoutCubit() : super(InitialLayoutNavBarState());

  int currentIndex = 0;

  List<Widget> views = [
    const HomeView(),
    const ExploreView(),
    const HistoryView(),
    const ProfileView(),
  ];

  changeIndex(int index) {
    currentIndex = index;
    emit(ChangeLayoutNavBarState());
  }
}
