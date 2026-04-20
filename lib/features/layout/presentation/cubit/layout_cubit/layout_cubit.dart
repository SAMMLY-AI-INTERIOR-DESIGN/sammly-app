import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sammly/features/layout/presentation/cubit/layout_cubit/layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(InitialLayoutNavBarState());

  int currentIndex = 0;

  List<Widget> views = [
    const Scaffold(body: Center(child: Text('home'))),
    const Scaffold(body: Center(child: Text('explore'))),
    const Scaffold(body: Center(child: Text('History'))),
    const Scaffold(body: Center(child: Text('Profile'))),
  ];

  changeIndex(int index) {
    currentIndex = index;
    emit(ChangeLayoutNavBarState());
  }
}