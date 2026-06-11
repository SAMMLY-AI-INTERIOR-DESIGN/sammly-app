
// --- States ---
abstract class GenerationState {}

class GenerationInitial extends GenerationState {}

class GenerationLoadingStep extends GenerationState {
  final int stepIndex; // 0 to 3
  GenerationLoadingStep(this.stepIndex);
}

class GenerationFinished extends GenerationState {
  final String? imageUrl;
  GenerationFinished({this.imageUrl});
}

class GenerationFailed extends GenerationState {
  final String errorMsg;
  GenerationFailed({required this.errorMsg});
}