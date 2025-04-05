import 'package:equatable/equatable.dart';
import 'package:sell_point/domain/user/user.dart';

abstract class LoadUsersState {}

class InitialLoadUsersState extends LoadUsersState {}

class LoadingUsersState extends Equatable implements LoadUsersState {
  @override
  List<Object?> get props => [];
}

class UsersLoadedState extends Equatable implements LoadUsersState {
  final List<User> users;

  const UsersLoadedState(this.users);

  @override
  List<Object?> get props => [users];
}

class UsersLoadErrorState extends Equatable implements LoadUsersState {
  final bool isConnectionError;

  const UsersLoadErrorState({
    required this.isConnectionError,
  });

  @override
  List<Object?> get props => [isConnectionError];
}
