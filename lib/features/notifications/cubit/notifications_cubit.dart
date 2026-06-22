import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sammly/features/notifications/data/repo/notifications_repo.dart';
import 'package:sammly/features/notifications/cubit/notifications_states.dart';
import 'package:sammly/core/shared_pref/shared_pref.dart';
import 'package:sammly/features/notifications/data/model/notifications_model.dart';

class NotificationsCubit extends Cubit<NotificationsState> {

  @override
  void emit(NotificationsState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }

  final NotificationsRepo _repo;
  NotificationsCubit(this._repo) : super(NotificationsInitial());

  static NotificationsCubit get(context) => BlocProvider.of(context);

  List<NotificationItemModel> notifications = [];
  int _currentPage = 1;
  bool _hasMore = true;
  bool _isLoading = false;

  /// Resets all in-memory notification state (used on logout).
  void reset() {
    notifications.clear();
    _currentPage = 1;
    _hasMore = true;
    _isLoading = false;
    emit(NotificationsInitial());
  }

  Future<void> getNotifications({bool loadMore = false}) async {
    if (_isLoading) return;
    if (!loadMore) {
      if (isClosed) return;
      _isLoading = true;
      emit(GetNotificationsLoading());
      _currentPage = 1;
      notifications.clear();
      _hasMore = true;
    } else {
      if (!_hasMore) return;
      _isLoading = true;
    }

    final result = await _repo.getNotifications(page: _currentPage);
    _isLoading = false;
    if (isClosed) return;
    result.fold((error) => emit(GetNotificationsFailure(error)), (response) {
      if (!loadMore) {
        notifications = response.notifications;
        if (notifications.isNotEmpty) {
          SharedPref.saveData(
            key: 'last_seen_notification_id',
            value: notifications.first.id,
          );
        }
      } else {
        notifications.addAll(response.notifications);
      }
      _currentPage++;
      _hasMore = response.hasMore;
      if (isClosed) return;
      emit(GetNotificationsSuccess(response));
    });
  }
}
