import 'package:sammly/features/generate/data/model/generate_design_response_model.dart';

abstract class GenerateDesignState {}

class GenerateDesignInitial extends GenerateDesignState {}

class GenerateDesignLoading extends GenerateDesignState {}

class GenerateDesignSuccess extends GenerateDesignState {
  final List<GenerateDesignResponseModel> designs;
  GenerateDesignSuccess({required this.designs});
}

class GenerateDesignFailure extends GenerateDesignState {
  final String errorMsg;
  GenerateDesignFailure({required this.errorMsg});
}
