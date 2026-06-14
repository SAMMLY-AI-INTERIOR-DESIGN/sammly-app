import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sammly/features/generate/data/model/generate_mappers.dart';
import 'package:sammly/features/generate/data/repo/generate_design_repo.dart';
import 'package:sammly/features/generate/presentation/cubits/generate_design_state.dart';

class GenerateDesignCubit extends Cubit<GenerateDesignState> {
  final GenerateDesignRepo generateDesignRepo;

  GenerateDesignCubit(this.generateDesignRepo) : super(GenerateDesignInitial());

  @override
  void emit(GenerateDesignState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }

  /// Generates a design using the API.
  /// [uiStyle] and [uiRoom] are the raw UI display values
  /// (e.g. "Boho", "Dining Room") — they will be mapped to API values internally.
  Future<void> generateDesign({
    required String uiStyle,
    required String uiRoom,
    required String prompt,
    String? imageUrl,
  }) async {
    emit(GenerateDesignLoading());

    // Map UI values to API values
    final apiStyle = GenerateMappers.styleToApi(uiStyle);
    final apiRoom = GenerateMappers.roomToApi(uiRoom);

    final result = await generateDesignRepo.generateDesign(
      style: apiStyle,
      room: apiRoom,
      prompt: prompt,
      imageUrl: imageUrl,
    );

    result.fold(
      (error) => emit(GenerateDesignFailure(errorMsg: error)),
      (design) => emit(GenerateDesignSuccess(designs: [design])),
    );
  }

  Future<void> restyleDesign({
    required String uiStyle,
    required String imageUrl,
  }) async {
    emit(GenerateDesignLoading());

    // Map UI values to API values
    final apiStyle = GenerateMappers.styleToApi(uiStyle);

    final result = await generateDesignRepo.restyleDesign(
      style: apiStyle,
      imageUrl: imageUrl,
    );

    result.fold(
      (error) => emit(GenerateDesignFailure(errorMsg: error)),
      (design) => emit(GenerateDesignSuccess(designs: [design])),
    );
  }
}
