import 'package:sammly/features/Explore/data/exploremodel.dart';

abstract class ExploreState {}

class ExploreInitial extends ExploreState {}

class ExploreLoading extends ExploreState {}

class ExplorePaginationLoading extends ExploreState {}

class ExploreLoaded extends ExploreState {
  final List<ExploreDesignModel> designs;
  final int currentPage;
  final bool hasMore;

  ExploreLoaded({
    required this.designs,
    required this.currentPage,
    required this.hasMore,
  });
}

class ExploreError extends ExploreState {
  final String message;

  ExploreError(this.message);
}
