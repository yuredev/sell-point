import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:sell_point/domain/product/product.dart';

part 'product_repository.g.dart';

@RestApi()
abstract class ProductRepository {
  factory ProductRepository(Dio dio, String apiURL) =>
      ProductRepository.retrofit(dio, baseUrl: '$apiURL/products');

  factory ProductRepository.retrofit(Dio dio, {required String baseUrl}) =
      _ProductRepository;

  @GET('')
  Future<List<Product>> getAll();

  @POST('')
  Future<void> create(@Body() Product product);
}
