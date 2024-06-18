import 'package:flutter_clean_architecture_template/app/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.userId,
    required super.name,
    required super.imageUrl,
    required super.region,
    required super.adress,
    required super.adressNumber,
  });

  UserModel copyWith({
    String? userId,
    String? name,
    String? imageUrl,
    String? region,
    String? adress,
    int? adressNumber,
  }) {
    return UserModel(
      userId: userId ?? super.userId,
      name: name ?? super.name,
      imageUrl: imageUrl ?? super.imageUrl,
      region: region ?? super.region,
      adress: adress ?? super.adress,
      adressNumber: adressNumber ?? super.adressNumber,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      userId: map['user_id'],
      name: map['name'],
      imageUrl: map['image_url'],
      region: map['region'],
      adress: map['adress'],
      adressNumber: map['adress_number'],
    );
  }
}
