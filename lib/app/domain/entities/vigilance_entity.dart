import 'package:flutter_clean_architecture_template/app/domain/entities/good_near_user_entity.dart';
import 'package:flutter_clean_architecture_template/app/domain/entities/incident_near_user_entity.dart';

class VigilanceEntity {
  final List<IncidentNearUserEntity> incidents;
  final List<GoodNearUserEntity> goods;

  VigilanceEntity({
    required this.incidents,
    required this.goods,
  });
}
