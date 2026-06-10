
// --- States ---
abstract class GenerationState {}

class GenerationInitial extends GenerationState {}

class GenerationLoadingStep extends GenerationState {
  final int stepIndex; // هتشيل رقم من 0 لـ 3
  GenerationLoadingStep(this.stepIndex);
}

class GenerationFinished extends GenerationState {}