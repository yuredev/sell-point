import 'package:retrofit/retrofit.dart';
import 'package:sell_point/domain/user/user.dart';
import 'package:dio/dio.dart';

part 'user_repository.g.dart';

@RestApi()
abstract class UserRepository {
  factory UserRepository(Dio dio, String apiURL) =>
      UserRepository.retrofit(dio, baseUrl: '$apiURL/users');

  factory UserRepository.retrofit(Dio dio, {required String baseUrl}) =
      _UserRepository;

  @GET('')
  Future<List<User>> getAll();
}
