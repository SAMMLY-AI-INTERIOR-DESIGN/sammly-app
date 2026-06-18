import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sammly/features/smart_lens/cubit/search_state.dart';
import 'package:sammly/features/smart_lens/data/repo/search_repo.dart';

class SearchCubit extends Cubit<SearchState> {

  @override
  void emit(SearchState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }

  final SearchRepo _repo;

  SearchCubit(this._repo) : super(SearchInitial());

  Future<void> searchDesign(String designId) async {
    if (isClosed) return;
    emit(SearchLoading());

    final result = await _repo.searchDesign(designId);

    if (isClosed) return;
    result.fold(
      (error) => emit(SearchError(error)),
      (response) => emit(SearchLoaded(response)),
    );
  }
}
