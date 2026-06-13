import 'package:sammly/features/Explore/data/static_design_model.dart';

abstract class StaticDesignsState {}

class StaticDesignsInitial extends StaticDesignsState {}

class StaticDesignsLoading extends StaticDesignsState {}

class StaticDesignsPaginationLoading extends StaticDesignsState {}

class StaticDesignsLoaded extends StaticDesignsState {
  final List<StaticDesignModel> designs;
  final int currentPage;
  final bool hasMore;

  StaticDesignsLoaded({
    required this.designs,
    required this.currentPage,
    required this.hasMore,
  });
}

class StaticDesignsError extends StaticDesignsState {
  final String message;

  StaticDesignsError(this.message);
}
