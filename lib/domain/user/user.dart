import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  final int id;
  final String username;
  final String email;
  final String password;

  const User({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  User copyWith({
    int? id,
    String? username,
    String? email,
    String? password,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  User copyWithout({
    bool id = false,
    bool username = false,
    bool email = false,
    bool password = false,
  }) {
    return User(
      id: id ? 0 : this.id,
      username: username ? '' : this.username,
      email: email ? '' : this.email,
      password: password ? '' : this.password,
    );
  }

  @override
  List<Object?> get props => [id, username, email, password];
}
