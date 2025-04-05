// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sell_point/logic/cubits/user/load/load_users_state.dart';
import 'package:sell_point/repository/user/user_repository.dart';

class LoadUsersCubit extends Cubit<LoadUsersState> {
  final UserRepository userRepository;

  LoadUsersCubit({required this.userRepository})
      : super(InitialLoadUsersState());

  Future<void> load() async {
    try {
      emit(LoadingUsersState());
      final users = await userRepository.getAll();
      emit(UsersLoadedState(users));
    } catch (e) {
      print(e);
      emit(UsersLoadErrorState(isConnectionError: e is DioException));
    }
  }
}
