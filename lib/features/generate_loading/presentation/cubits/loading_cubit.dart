import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sammly/features/generate_loading/presentation/cubits/loading_states.dart';



// --- Cubit ---
class GenerationCubit extends Cubit<GenerationState> {
  GenerationCubit() : super(GenerationInitial());

  Timer? _timer;
  int _currentStep = 0;

  void startLoadingCycle() {
    _currentStep = 0;
    emit(GenerationLoadingStep(_currentStep)); // ابدأ بأول شاشة فوراً

    // شغل الـ Timer عشان يكرر الكود كل ثانيتين
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (_currentStep < 3) {
        _currentStep++;
        emit(GenerationLoadingStep(_currentStep)); // ابعت الـ State بالشاشة الجديدة
      } else {
        // لو وصلنا لآخر شاشة (رقم 3)، وقف الـ Timer عشان ميفضلش يعد عالفاضي
        _timer?.cancel(); 
        emit(GenerationFinished());
        
        // ملاحظة: لو عايزهم يلفوا من الأول تاني للأبد، بدل سطر الـ cancel خليها:
        // _currentStep = 0; 
        // emit(GenerationLoadingStep(_currentStep));
      }
    });
  }

  // 🔴 مهم جداً جداً 🔴
  // لازم نوقف الـ Timer لما اليوزر يخرج من الشاشة عشان ميعملش كراش أو يستهلك الرامات
  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}