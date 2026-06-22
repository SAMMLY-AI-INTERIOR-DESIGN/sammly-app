import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sammly/features/subscrition/cubit/subscription_states.dart';
import 'package:sammly/features/subscrition/data/subscription_repo.dart';

class SubscriptionCubit extends Cubit<SubscriptionState> {
  @override
  void emit(SubscriptionState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }

  final SubscriptionRepo _repo;
  List<PackageModel> packagesList = [];

  SubscriptionCubit(this._repo) : super(SubscriptionInitial());

  Future<void> getPackages() async {
    if (isClosed) return;
    emit(PackagesLoading());

    final result = await _repo.getPackages();
    if (isClosed) return;

    result.fold(
      (error) => emit(PackagesError(error)),
      (packages) {
        packagesList = packages;
        emit(PackagesLoaded(packages));
      },
    );
  }

  Future<void> claimPackage(String packageId) async {
    if (isClosed) return;
    emit(SubscriptionLoading(packageId));

    final result = await _repo.claimPackage(packageId);
    if (isClosed) return;

    result.fold(
      (error) => emit(ClaimFailure(error)),
      (claimResult) {
        emit(ClaimSuccess(claimResult));
        // Re-emit loaded state so UI can rebuild packages list if needed
        emit(PackagesLoaded(packagesList));
      },
    );
  }
}
