
// --- States ---
import 'package:sammly/features/generate/data/model/generate_design_response_model.dart';

abstract class GenerationState {}

class GenerationInitial extends GenerationState {}

class GenerationLoadingStep extends GenerationState {
  final int stepIndex; // 0 to 3
  GenerationLoadingStep(this.stepIndex);
}

class GenerationFinished extends GenerationState {
  final String? imageUrl;
  final String? designId;
  final List<GenerateDesignResponseModel>? designs;
  GenerationFinished({this.imageUrl, this.designId, this.designs});
}

class GenerationFailed extends GenerationState {
  final String errorMsg;
  GenerationFailed({required this.errorMsg});
}