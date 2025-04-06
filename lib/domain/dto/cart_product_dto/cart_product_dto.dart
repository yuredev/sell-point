import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart_product_dto.g.dart';

@JsonSerializable()
class CartProductDto extends Equatable {
  final int productId;
  final int quantity;

  const CartProductDto({
    required this.productId,
    required this.quantity,
  });

  factory CartProductDto.fromJson(Map<String, dynamic> json) =>
      _$CartProductDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CartProductDtoToJson(this);

  CartProductDto copyWith({
    int? productId,
    int? quantity,
  }) {
    return CartProductDto(
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
    );
  }

  CartProductDto copyWithout({
    bool productId = false,
    bool quantity = false,
  }) {
    return CartProductDto(
      productId: productId ? 0 : this.productId,
      quantity: quantity ? 0 : this.quantity,
    );
  }

  @override
  List<Object?> get props => [productId, quantity];
}