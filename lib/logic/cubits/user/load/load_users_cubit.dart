import 'package:dio/dio.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:sell_point/core/constants/durations.dart';
import 'package:sell_point/domain/user/user.dart';
import 'package:sell_point/logic/cubits/user/load/load_users_state.dart';
import 'package:sell_point/repository/user/user_repository.dart';
import 'package:sell_point/utils/date_time_utils.dart';

class LoadUsersCubit extends HydratedCubit<LoadUsersState> {
  final UserRepository userRepository;

  LoadUsersCubit({required this.userRepository})
    : super(InitialLoadUsersState());

  bool get shouldRefresh {
    if (state is! UsersLoadedState) {
      return true;
    }
    return DateTime.now()
        .subtract(Duration(minutes: Durations.minutesRefreshRate))
        .isAfter((state as UsersLoadedState).lastTimeUpdated);
  }

  List<User> get users {
    if (state is! UsersLoadedState) {
      return [];
    }
    return (state as UsersLoadedState).users;
  }

  Future<void> load() async {
    try {
      emit(LoadingUsersState());
      final users = await userRepository.getAll();
      final agora = DateTime.now();
      emit(UsersLoadedState(users, agora));
    } catch (e) {
      print(e);
      emit(UsersLoadErrorState(isConnectionError: e is DioException));
    }
  }

  @override
  LoadUsersState? fromJson(Map<String, dynamic> json) {
    try {
      final users =
          (json['users'] as List).map((e) => User.fromJson(e)).toList();
      final lastTimeUpdated = DateTimeUtils.fromBRLFormat(
        json['lastTimeUpdated'],
      );
      return UsersLoadedState(users, lastTimeUpdated);
    } catch (_) {
      return InitialLoadUsersState();
    }
  }

  @override
  Map<String, dynamic>? toJson(LoadUsersState state) {
    if (state is UsersLoadedState) {
      return {
        'users': state.users.map((e) => e.toJson()).toList(),
        'lastTimeUpdated': DateTimeUtils.dateToBRLFormat(state.lastTimeUpdated),
      };
    }
    return null;
  }
}
