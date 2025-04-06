import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sell_point/domain/dto/cart_product_dto/cart_product_dto.dart';

part 'cart_dto.g.dart';

@JsonSerializable()
class CartDto extends Equatable {
  final int id;
  final int userId;
  final List<CartProductDto> products;

  const CartDto({
    required this.id,
    required this.userId,
    required this.products,
  });

  factory CartDto.fromJson(Map<String, dynamic> json) =>
      _$CartDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CartDtoToJson(this);

  CartDto copyWith({
    int? id,
    int? userId,
    List<CartProductDto>? products,
  }) {
    return CartDto(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      products: products ?? this.products,
    );
  }

  CartDto copyWithout({
    bool id = false,
    bool userId = false,
    bool products = false,
  }) {
    return CartDto(
      id: id ? 0 : this.id,
      userId: userId ? 0 : this.userId,
      products: products ? [] : this.products,
    );
  }

  @override
  List<Object?> get props => [id, userId, products];
}
