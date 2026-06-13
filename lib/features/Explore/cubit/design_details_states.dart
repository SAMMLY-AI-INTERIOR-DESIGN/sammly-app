import 'package:sammly/features/Explore/data/design_details_model.dart';

abstract class DesignDetailsState {}

class DesignDetailsInitial extends DesignDetailsState {}

class DesignDetailsLoading extends DesignDetailsState {}

class DesignDetailsLoaded extends DesignDetailsState {
  final DesignDetailsModel design;
  final DesignCreatorModel? creator;

  DesignDetailsLoaded({
    required this.design,
    this.creator,
  });
}

class DesignDetailsError extends DesignDetailsState {
  final String message;

  DesignDetailsError(this.message);
}

// Action states (share, cancel-share, like, unlike)
class DesignActionLoading extends DesignDetailsState {}

class DesignShareSuccess extends DesignDetailsState {
  final String message;

  DesignShareSuccess(this.message);
}

class DesignCancelShareSuccess extends DesignDetailsState {
  final String message;

  DesignCancelShareSuccess(this.message);
}

class DesignLikeSuccess extends DesignDetailsState {
  final String message;

  DesignLikeSuccess(this.message);
}

class DesignUnlikeSuccess extends DesignDetailsState {
  final String message;

  DesignUnlikeSuccess(this.message);
}

class DesignActionError extends DesignDetailsState {
  final String message;

  DesignActionError(this.message);
}
