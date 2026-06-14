import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sammly/features/generate/data/model/generate_mappers.dart';
import 'package:sammly/features/generate/data/repo/generate_design_repo.dart';
import 'package:sammly/features/generate_loading/presentation/cubits/loading_states.dart';

class GenerationCubit extends Cubit<GenerationState> {
  GenerationCubit() : super(GenerationInitial());

  Timer? _timer;
  int _currentStep = 0;

  void startLoadingWithApi({
    required String uiStyle,
    required String uiRoom,
    required String prompt,
    String? imageUrl,
    required GenerateDesignRepo repo,
  }) {
    _currentStep = 0;
    
    emit(GenerationLoadingStep(_currentStep));

    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      _currentStep = (_currentStep + 1) % 4; 
      emit(GenerationLoadingStep(_currentStep));
    });

    _callApi(
      uiStyle: uiStyle,
      uiRoom: uiRoom,
      prompt: prompt,
      imageUrl: imageUrl,
      repo: repo,
    );
  }

  Future<void> _callApi({
    required String uiStyle,
    required String uiRoom,
    required String prompt,
    String? imageUrl,
    required GenerateDesignRepo repo,
  }) async {
    final apiStyle = GenerateMappers.styleToApi(uiStyle);
    final apiRoom = GenerateMappers.roomToApi(uiRoom);

    final result = await repo.generateDesign(
      style: apiStyle,
      room: apiRoom,
      prompt: prompt,
      imageUrl: imageUrl,
    );

    _timer?.cancel();

    result.fold(
      (error) {
        emit(GenerationFailed(errorMsg: error));
      },
      (design) {
        emit(GenerationFinished(imageUrl: design.imageUrl, designId: design.id));
      },
    );
  }

  void startRestyleWithApi({
    required String uiStyle,
    required String imageUrl,
    required GenerateDesignRepo repo,
  }) {
    _currentStep = 0;
    
    emit(GenerationLoadingStep(_currentStep));

    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      _currentStep = (_currentStep + 1) % 4; 
      emit(GenerationLoadingStep(_currentStep));
    });

    _callRestyleApi(
      uiStyle: uiStyle,
      imageUrl: imageUrl,
      repo: repo,
    );
  }

  Future<void> _callRestyleApi({
    required String uiStyle,
    required String imageUrl,
    required GenerateDesignRepo repo,
  }) async {
    final apiStyle = GenerateMappers.styleToApi(uiStyle);

    final result = await repo.restyleDesign(
      style: apiStyle,
      imageUrl: imageUrl,
    );

    _timer?.cancel();

    result.fold(
      (error) {
        emit(GenerationFailed(errorMsg: error));
      },
      (design) {
        emit(GenerationFinished(imageUrl: design.imageUrl, designId: design.id));
      },
    );
  }

  void startFullHomeWithApi({
    required String uiStyle,
    required List<String> uiRoomTypes,
    String? imageUrl,
    required GenerateDesignRepo repo,
  }) {
    _currentStep = 0;
    
    emit(GenerationLoadingStep(_currentStep));

    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      _currentStep = (_currentStep + 1) % 4; 
      emit(GenerationLoadingStep(_currentStep));
    });

    _callFullHomeApi(
      uiStyle: uiStyle,
      uiRoomTypes: uiRoomTypes,
      imageUrl: imageUrl,
      repo: repo,
    );
  }

  Future<void> _callFullHomeApi({
    required String uiStyle,
    required List<String> uiRoomTypes,
    String? imageUrl,
    required GenerateDesignRepo repo,
  }) async {
    final apiStyle = GenerateMappers.styleToApi(uiStyle);
    final apiRoomTypes = uiRoomTypes.map((room) => GenerateMappers.roomToApi(room)).toList();

    final result = await repo.generateFullHomeDesign(
      style: apiStyle,
      roomTypes: apiRoomTypes,
      styleImageUrl: imageUrl,
    );

    _timer?.cancel();

    result.fold(
      (error) {
        emit(GenerationFailed(errorMsg: error));
      },
      (designs) {
        if (designs.isNotEmpty) {
          emit(GenerationFinished(
            imageUrl: designs.first.imageUrl, 
            designId: designs.first.id,
            designs: designs,
          ));
        } else {
          emit(GenerationFailed(errorMsg: 'No designs returned.'));
        }
      },
    );
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}