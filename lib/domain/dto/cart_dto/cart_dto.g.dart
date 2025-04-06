// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartDto _$CartDtoFromJson(Map<String, dynamic> json) => CartDto(
  id: (json['id'] as num).toInt(),
  userId: (json['userId'] as num).toInt(),
  products:
      (json['products'] as List<dynamic>)
          .map((e) => CartProductDto.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$CartDtoToJson(CartDto instance) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'products': instance.products,
};
