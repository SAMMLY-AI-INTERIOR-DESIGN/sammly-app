import 'package:sammly/features/subscrition/data/subscription_repo.dart';

abstract class SubscriptionState {}

class SubscriptionInitial extends SubscriptionState {}

class SubscriptionLoading extends SubscriptionState {
  final String packageId;
  SubscriptionLoading(this.packageId);
}
class PackagesLoading extends SubscriptionState {} // Used for initial fetch

class PackagesLoaded extends SubscriptionState {
  final List<PackageModel> packages;
  PackagesLoaded(this.packages);
}

class PackagesError extends SubscriptionState {
  final String error;
  PackagesError(this.error);
}

class ClaimSuccess extends SubscriptionState {
  final ClaimResult result;
  ClaimSuccess(this.result);
}

class ClaimFailure extends SubscriptionState {
  final String error;
  ClaimFailure(this.error);
}

// IAP Purchase states
class PurchaseInProgress extends SubscriptionState {
  final String productId;
  PurchaseInProgress(this.productId);
}

class PurchaseSuccess extends SubscriptionState {
  final String message;
  final int? credits;
  PurchaseSuccess({required this.message, this.credits});
}

class PurchaseFailure extends SubscriptionState {
  final String error;
  PurchaseFailure(this.error);
}

class PurchaseRestored extends SubscriptionState {
  final String message;
  PurchaseRestored(this.message);
}
