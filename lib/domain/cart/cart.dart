import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sell_point/domain/product/product.dart';

part 'cart.g.dart';

@JsonSerializable(explicitToJson: true)
class Cart extends Equatable {
  final int id;
  final int userId;
  final List<Product> products;

  const Cart({required this.id, required this.userId, required this.products});

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);

  Map<String, dynamic> toJson() => _$CartToJson(this);

  Cart copyWith({int? id, int? userId, List<Product>? products}) {
    return Cart(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      products: products ?? this.products,
    );
  }

  Cart copyWithout({
    bool id = false,
    bool userId = false,
    bool products = false,
  }) {
    return Cart(
      id: id ? 0 : this.id,
      userId: userId ? 0 : this.userId,
      products: products ? [] : this.products,
    );
  }

  @override
  List<Object?> get props => [id, userId, products];
}
