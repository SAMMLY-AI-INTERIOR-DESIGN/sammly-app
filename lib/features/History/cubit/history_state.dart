import 'package:sammly/features/History/data/historymodel.dart';

abstract class HistoryState {}

class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistoryPaginationLoading extends HistoryState {}

class HistoryLoaded extends HistoryState {
  final List<HistoryDesignModel> designs;
  final int currentPage;
  final int totalDesigns;
  final bool hasMore;

  HistoryLoaded({
    required this.designs,
    required this.currentPage,
    required this.totalDesigns,
    required this.hasMore,
  });
}

class HistoryError extends HistoryState {
  final String message;

  HistoryError(this.message);
}
