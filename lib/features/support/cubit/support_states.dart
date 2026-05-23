abstract class SupportState {}

class SupportInitialState extends SupportState {}

class SendSupportLoadingState extends SupportState {}

class SendSupportSuccessState extends SupportState {}

class SendSupportFailedState extends SupportState {
  final String errorMsg;
  SendSupportFailedState({required this.errorMsg});
}
