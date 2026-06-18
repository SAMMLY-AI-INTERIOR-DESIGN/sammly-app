import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sammly/core/shared_pref/shared_pref.dart';
import 'package:sammly/features/Explore/cubit/design_details_states.dart';
import 'package:sammly/features/Explore/cubit/design_details_repo.dart';
import 'package:sammly/features/Explore/data/design_details_model.dart';

class DesignDetailsCubit extends Cubit<DesignDetailsState> {

  @override
  void emit(DesignDetailsState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }

  final DesignDetailsRepo _repository;

  DesignDetailsCubit(this._repository) : super(DesignDetailsInitial()) {
    _loadSharedDesignIds();
  }

  DesignDetailsModel? _currentDesign;
  DesignCreatorModel? _currentCreator;

  final Set<String> _sharedDesignIds = {};

  DesignDetailsModel? get currentDesign => _currentDesign;
  DesignCreatorModel? get currentCreator => _currentCreator;

  /// Whether the current user is the publisher (creator is null).
  bool get isPublisher => _currentCreator == null && _currentDesign != null;

  void _loadSharedDesignIds() {
    final ids = SharedPref.getData(key: 'shared_design_ids') ?? '';
    if (ids.isNotEmpty) {
      _sharedDesignIds.addAll(ids.split(','));
    }
  }

  void _saveSharedDesignId(String id) {
    _sharedDesignIds.add(id);
    SharedPref.saveData(
      key: 'shared_design_ids',
      value: _sharedDesignIds.join(','),
    );
  }

  bool isSharedLocal(String designId) {
    return _sharedDesignIds.contains(designId);
  }

  /// Fetch design details by ID.
  Future<void> fetchDesignDetails(
    String designId, {
    String? overrideId,
    bool? overrideIsLiked,
    bool? overrideIsFavorited,
    int? overrideLikesCount,
  }) async {
    emit(DesignDetailsLoading());

    final result = await _repository.getDesignDetails(designId);

    result.fold((error) => emit(DesignDetailsError(error)), (response) {
      _currentDesign = response.design;
      if (overrideId != null) {
        _currentDesign = _currentDesign!.copyWith(
          id: overrideId,
          isLiked: overrideIsLiked ?? _currentDesign!.isLiked,
          isFavorited: overrideIsFavorited ?? _currentDesign!.isFavorited,
          likesCount: overrideLikesCount ?? _currentDesign!.likesCount,
        );
      }
      _currentCreator = response.creator;
      if (_currentDesign!.isShared) {
        _saveSharedDesignId(_currentDesign!.id);
      }

      emit(
        DesignDetailsLoaded(design: _currentDesign!, creator: _currentCreator),
      );
    });
  }

  /// Share design to explore.
  Future<void> shareDesign(String designId) async {
    emit(DesignActionLoading());

    final result = await _repository.shareDesign(designId);

    result.fold(
      (error) {
        // Even if error is "already shared", we can mark it locally
        if (error.toLowerCase().contains('already shared')) {
          _saveSharedDesignId(designId);
          emit(DesignShareSuccess("Design already shared"));
          _emitLoadedIfAvailable();
        } else {
          emit(DesignActionError(error));
          _emitLoadedIfAvailable();
        }
      },
      (message) {
        // Update local state
        _saveSharedDesignId(designId);
        if (_currentDesign != null) {
          _currentDesign = _currentDesign!.copyWith(
            sharedAt: DateTime.now().toIso8601String(),
          );
        }
        emit(DesignShareSuccess(message));
        _emitLoadedIfAvailable();
      },
    );
  }

  /// Cancel sharing from explore.
  Future<void> cancelShareDesign(String designId) async {
    emit(DesignActionLoading());

    final result = await _repository.cancelShareDesign(designId);

    result.fold(
      (error) {
        emit(DesignActionError(error));
        _emitLoadedIfAvailable();
      },
      (message) {
        // Update local state: remove sharedAt
        if (_currentDesign != null) {
          _currentDesign = DesignDetailsModel(
            id: _currentDesign!.id,
            prompt: _currentDesign!.prompt,
            imageUrl: _currentDesign!.imageUrl,
            room: _currentDesign!.room,
            style: _currentDesign!.style,
            likesCount: _currentDesign!.likesCount,
            isLiked: _currentDesign!.isLiked,
            isFavorited: _currentDesign!.isFavorited,
            sharedAt: null,
          );
        }
        emit(DesignCancelShareSuccess(message));
        _emitLoadedIfAvailable();
      },
    );
  }

  /// Toggle like: likes if not liked, unlikes if already liked.
  Future<void> toggleLike(String designId) async {
    if (_currentDesign == null) return;

    final wasLiked = _currentDesign!.isLiked;

    // Optimistic update
    _currentDesign = _currentDesign!.copyWith(
      isLiked: !wasLiked,
      likesCount: wasLiked
          ? _currentDesign!.likesCount - 1
          : _currentDesign!.likesCount + 1,
    );
    _emitLoadedIfAvailable();

    // Call API
    final result = wasLiked
        ? await _repository.unlikeDesign(designId)
        : await _repository.likeDesign(designId);

    result.fold(
      (error) {
        // Revert optimistic update on failure
        _currentDesign = _currentDesign!.copyWith(
          isLiked: wasLiked,
          likesCount: wasLiked
              ? _currentDesign!.likesCount + 1
              : _currentDesign!.likesCount - 1,
        );
        emit(DesignActionError(error));
        _emitLoadedIfAvailable();
      },
      (message) {
        // Already updated optimistically, emit success
        if (wasLiked) {
          emit(DesignUnlikeSuccess(message));
        } else {
          emit(DesignLikeSuccess(message));
        }
        _emitLoadedIfAvailable();
      },
    );
  }

  /// Helper to re-emit the loaded state after an action.
  void _emitLoadedIfAvailable() {
    if (_currentDesign != null) {
      emit(
        DesignDetailsLoaded(design: _currentDesign!, creator: _currentCreator),
      );
    }
  }

  /// Update local isFavorited state (called when FavoriteCubit toggles).
  void updateFavoriteStatus(bool isFavorited) {
    if (_currentDesign == null) return;
    _currentDesign = _currentDesign!.copyWith(isFavorited: isFavorited);
    _emitLoadedIfAvailable();
  }
}
