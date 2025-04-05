import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product extends Equatable {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;

  const Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  @override
  List<Object?> get props => [id, title, price, description, category, image];

  Product copyWith({
    int? id,
    String? title,
    double? price,
    String? description,
    String? category,
    String? image,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      description: description ?? this.description,
      category: category ?? this.category,
      image: image ?? this.image,
    );
  }

  Product copyWithout({
    bool id = false,
    bool title = false,
    bool price = false,
    bool description = false,
    bool category = false,
    bool image = false,
  }) {
    return Product(
      id: id ? 0 : this.id,
      title: title ? '' : this.title,
      price: price ? 0.0 : this.price,
      description: description ? '' : this.description,
      category: category ? '' : this.category,
      image: image ? '' : this.image,
    );
  }
}
