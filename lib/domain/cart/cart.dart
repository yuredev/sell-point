import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sell_point/domain/product/product.dart';
import 'package:sell_point/domain/user/user.dart';

part 'cart.g.dart';

@JsonSerializable(explicitToJson: true)
class Cart extends Equatable {
  final int id;
  final User user;
  final List<Product> products;

  const Cart({
    required this.id,
    required this.user,
    required this.products,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);

  Map<String, dynamic> toJson() => _$CartToJson(this);

  Cart copyWith({
    int? id,
    User? user,
    List<Product>? products,
  }) {
    return Cart(
      id: id ?? this.id,
      user: user ?? this.user,
      products: products ?? this.products,
    );
  }

  Cart copyWithout({
    bool id = false,
    bool user = false,
    bool products = false,
  }) {
    return Cart(
      id: id ? 0 : this.id,
      user: user ? const User(id: 0, username: '', email: '', password: '') : this.user,
      products: products ? [] : this.products,
    );
  }

  @override
  List<Object?> get props => [id, user, products];
}
