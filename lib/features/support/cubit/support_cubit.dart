import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sammly/features/support/cubit/support_states.dart';
import 'package:sammly/features/support/data/repo/support_repo.dart';

class SupportCubit extends Cubit<SupportState> {
  final SupportRepo supportRepo;

  SupportCubit(this.supportRepo) : super(SupportInitialState());

  @override
  void emit(SupportState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }

  // ── Send Support Request ──
  Future<void> sendSupportRequest({
    required String email,
    required String subject,
    required String message,
  }) async {
    emit(SendSupportLoadingState());
    final result = await supportRepo.sendSupportRequest(
      email: email,
      subject: subject,
      message: message,
    );
    result.fold(
      (error) => emit(SendSupportFailedState(errorMsg: error)),
      (success) => emit(SendSupportSuccessState()),
    );
  }
}
