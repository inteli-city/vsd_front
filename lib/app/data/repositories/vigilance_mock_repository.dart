import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_template/app/domain/entities/good_near_user_entity.dart';
import 'package:flutter_clean_architecture_template/app/domain/entities/incident_near_user_entity.dart';
import 'package:flutter_clean_architecture_template/app/domain/entities/vigilance_entity.dart';
import 'package:flutter_clean_architecture_template/app/domain/enum/good_type_enum.dart';
import 'package:flutter_clean_architecture_template/app/domain/enum/incident_type_enum.dart';
import 'package:flutter_clean_architecture_template/app/domain/failures/failures.dart';
import 'package:flutter_clean_architecture_template/app/domain/repositories/vigilance_repository.dart';

class VigilanceMockRepository implements IVigilanceRepository {
  List<VigilanceEntity> vigilances = [
    VigilanceEntity(
      incidents: [
        IncidentNearUserEntity(
          incidentId: '7ca55c05-11da-4758-ab08-16dd6107bcd9',
          description: 'Incidente 1',
          distance: 200,
          imageUrl: null,
          type: IncidentTypeEnum.ALARM_TRIGGERED,
        ),
        IncidentNearUserEntity(
          incidentId: '7ca55c05-11da-4758-ab08-16dd6107bcd9',
          description: 'Incidente 1',
          distance: 2000,
          imageUrl: null,
          type: IncidentTypeEnum.SUSPICIOUS_PERSON,
        ),
        IncidentNearUserEntity(
          incidentId: 'f02186f9-5130-42dd-9492-ef8a56b4d5b4',
          description: 'Incidente 2',
          distance: 8000,
          imageUrl: null,
          type: IncidentTypeEnum.SUSPICIOUS_VEHICLE,
        ),
      ],
      goods: [
        GoodNearUserEntity(
          distance: 500,
          type: GoodTypeEnum.POLICE,
        )
      ],
    ),
  ];

  @override
  Future<Either<Failure, List<VigilanceEntity>>> getVigilances() async {
    return Right(vigilances);
  }
}
