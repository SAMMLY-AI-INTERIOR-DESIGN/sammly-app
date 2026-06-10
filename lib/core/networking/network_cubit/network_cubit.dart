import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'network_state.dart';

class NetworkCubit extends Cubit<NetworkState> {
  final InternetConnection _internetConnection = InternetConnection();
  StreamSubscription? _internetSubscription;

  NetworkCubit() : super(NetworkInitial()) {
    _initNetworkMonitoring();
  }

  void _initNetworkMonitoring() async {
    // Initial check
    bool hasInternet = await _internetConnection.hasInternetAccess;
    if (hasInternet) {
      emit(NetworkConnected());
    } else {
      emit(NetworkDisconnected());
    }

    // Listen for continuous changes
    _internetSubscription = _internetConnection.onStatusChange.listen((InternetStatus status) {
      if (status == InternetStatus.connected) {
        emit(NetworkConnected());
      } else {
        emit(NetworkDisconnected());
      }
    });
  }

  @override
  Future<void> close() {
    _internetSubscription?.cancel();
    return super.close();
  }
}
