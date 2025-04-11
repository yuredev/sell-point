import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:sell_point/domain/dto/cart_dto/cart_dto.dart';
import 'package:sell_point/domain/dto/cart_product_dto/cart_product_dto.dart';

part 'cart_repository.g.dart';

@RestApi()
abstract class CartRepository {
  factory CartRepository(Dio dio, String apiURL) =>
      CartRepository.retrofit(dio, baseUrl: '$apiURL/carts');

  factory CartRepository.retrofit(Dio dio, {required String baseUrl}) =
      _CartRepository;

  @PUT('/{id}')
  Future<void> save(@Path() int id, @Body() CartDto cart);
}
