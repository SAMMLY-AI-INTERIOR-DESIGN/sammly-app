import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sammly/features/favorite/data/repo/favorite_repo.dart';
import 'package:sammly/features/favorite/presentation/cubit/favorite_state.dart';
import 'package:sammly/features/favorite/data/models/favorite_item_model.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final FavoriteRepo _repository;

  FavoriteCubit(this._repository) : super(FavoriteInitial());

  final List<FavoriteModel> _allDesigns = [];
  final Set<String> _favoriteIds = {};
  
  int _currentPage = 1;
  bool _hasMore = true;
  String _selectedRoom = 'all';

  int get currentPage => _currentPage;
  bool get hasMore => _hasMore;
  String get selectedRoom => _selectedRoom;
  List<FavoriteModel> get currentDesigns => List.unmodifiable(_allDesigns);
  Set<String> get favoriteIds => _favoriteIds;

  bool isFavorite(String designId) {
    return _favoriteIds.contains(designId);
  }

  Future<void> fetchFavorites({int limit = 20, String? room}) async {
    if (room != null) {
      _selectedRoom = room.toLowerCase();
    }

    _allDesigns.clear();
    _currentPage = 1;
    _hasMore = true;

    emit(FavoriteLoading());

    final result = await _repository.getFavorites(
      page: _currentPage,
      limit: limit,
      room: _selectedRoom,
    );

    result.fold(
      (error) => emit(FavoriteError(error)),
      (response) {
        _allDesigns.addAll(response.designs);
        
        // Update local favorite IDs set
        for (var design in response.designs) {
          _favoriteIds.add(design.id);
        }

        _currentPage = response.page;
        _hasMore = response.hasMore;

        emit(FavoriteLoaded(
          favorites: List.unmodifiable(_allDesigns),
          selectedRoom: _selectedRoom,
          currentPage: _currentPage,
          hasMore: _hasMore,
        ));
      },
    );
  }

  Future<void> loadMore({int limit = 20}) async {
    if (!_hasMore) return;

    emit(FavoritePaginationLoading());

    final nextPage = _currentPage + 1;

    final result = await _repository.getFavorites(
      page: nextPage,
      limit: limit,
      room: _selectedRoom,
    );

    result.fold(
      (error) => emit(FavoriteError(error)),
      (response) {
        _allDesigns.addAll(response.designs);
        
        for (var design in response.designs) {
          _favoriteIds.add(design.id);
        }

        _currentPage = response.page;
        _hasMore = response.hasMore;

        emit(FavoriteLoaded(
          favorites: List.unmodifiable(_allDesigns),
          selectedRoom: _selectedRoom,
          currentPage: _currentPage,
          hasMore: _hasMore,
        ));
      },
    );
  }

  Future<void> changeRoom(String room) async {
    final newRoom = room.toLowerCase();
    if (_selectedRoom == newRoom) return;
    await fetchFavorites(room: newRoom);
  }

  Future<void> toggleFavorite(String designId, bool isCurrentlyFavorite) async {
    // Optimistic UI update
    if (isCurrentlyFavorite) {
      _favoriteIds.remove(designId);
      _allDesigns.removeWhere((element) => element.id == designId);
    } else {
      _favoriteIds.add(designId);
    }

    // Emit loaded state to update UI immediately
    emit(FavoriteLoaded(
      favorites: List.unmodifiable(_allDesigns),
      selectedRoom: _selectedRoom,
      currentPage: _currentPage,
      hasMore: _hasMore,
    ));

    final result = isCurrentlyFavorite 
        ? await _repository.removeFromFavorite(designId)
        : await _repository.addToFavorite(designId);

    result.fold(
      (error) {
        // Revert optimistic update on error
        if (isCurrentlyFavorite) {
          _favoriteIds.add(designId);
        } else {
          _favoriteIds.remove(designId);
        }
        
        emit(FavoriteToggleError(error));
        emit(FavoriteLoaded(
          favorites: List.unmodifiable(_allDesigns),
          selectedRoom: _selectedRoom,
          currentPage: _currentPage,
          hasMore: _hasMore,
        ));
      },
      (message) {
        emit(FavoriteToggleSuccess(message));
      },
    );
  }
}