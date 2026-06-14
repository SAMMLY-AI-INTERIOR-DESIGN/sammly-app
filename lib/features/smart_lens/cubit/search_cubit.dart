import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sammly/features/smart_lens/cubit/search_state.dart';
import 'package:sammly/features/smart_lens/data/repo/search_repo.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepo _repo;

  SearchCubit(this._repo) : super(SearchInitial());

  Future<void> searchDesign(String designId) async {
    emit(SearchLoading());

    final result = await _repo.searchDesign(designId);

    result.fold(
      (error) => emit(SearchError(error)),
      (response) => emit(SearchLoaded(response)),
    );
  }
}
