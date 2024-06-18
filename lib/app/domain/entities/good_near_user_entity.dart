import 'package:flutter_clean_architecture_template/app/domain/enum/good_type_enum.dart';

class GoodNearUserEntity {
  final GoodTypeEnum type;
  final int distance; // meters

  GoodNearUserEntity({
    required this.type,
    required this.distance,
  });
}
