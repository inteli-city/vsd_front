import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_template/app/domain/entities/incident_near_user_entity.dart';
import 'package:flutter_clean_architecture_template/app/domain/entities/vigilance_entity.dart';
import 'package:flutter_clean_architecture_template/app/domain/failures/failures.dart';

abstract class IVigilanceRepository {
  Future<Either<Failure, VigilanceEntity>> getVigilances();
  Future<Either<Failure, VigilanceEntity>> createIncident(
    IncidentNearUserEntity incident,
  );
}
