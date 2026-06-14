import 'package:sammly/features/smart_lens/data/models/search_response.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final SearchResponse response;

  SearchLoaded(this.response);
}

class SearchError extends SearchState {
  final String message;

  SearchError(this.message);
}
