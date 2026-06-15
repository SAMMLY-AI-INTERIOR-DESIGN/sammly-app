import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sammly/features/notifications/data/repo/notifications_repo.dart';
import 'package:sammly/features/notifications/cubit/notifications_states.dart';
import 'package:sammly/features/notifications/data/model/notifications_model.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  final NotificationsRepo _repo;
  NotificationsCubit(this._repo) : super(NotificationsInitial());

  static NotificationsCubit get(context) => BlocProvider.of(context);

  List<NotificationItemModel> notifications = [];
  int _currentPage = 1;
  bool _hasMore = true;

  Future<void> getNotifications({bool loadMore = false}) async {
    if (!loadMore) {
      if (isClosed) return;
      emit(GetNotificationsLoading());
      _currentPage = 1;
      notifications.clear();
      _hasMore = true;
    } else {
      if (!_hasMore) return;
    }

    final result = await _repo.getNotifications(page: _currentPage);
    if (isClosed) return;
    result.fold(
      (error) => emit(GetNotificationsFailure(error)),
      (response) {
        if (!loadMore) {
          notifications = response.notifications;
        } else {
          notifications.addAll(response.notifications);
        }
        _currentPage++;
        _hasMore = response.hasMore;
        if (isClosed) return;
        emit(GetNotificationsSuccess(response));
      },
    );
  }
}
