import 'package:retrofit/retrofit.dart';
import 'package:sell_point/domain/cart/cart.dart';
import 'package:dio/dio.dart';

part 'cart_repository.g.dart';

@RestApi()
abstract class CartRepository {
  factory CartRepository(Dio dio, String apiURL) =>
      CartRepository.retrofit(dio, baseUrl: '$apiURL/carts');

  factory CartRepository.retrofit(Dio dio, {required String baseUrl}) =
      _CartRepository;

  @GET('')
  Future<List<Cart>> getAll();

  @POST('')
  Future<void> create(@Body() Cart cart);
}
