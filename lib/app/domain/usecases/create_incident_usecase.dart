import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_template/app/domain/entities/incident_near_user_entity.dart';
import 'package:flutter_clean_architecture_template/app/domain/entities/vigilance_entity.dart';
import 'package:flutter_clean_architecture_template/app/domain/failures/failures.dart';
import 'package:flutter_clean_architecture_template/app/domain/repositories/vigilance_repository.dart';

abstract class ICreateIncidentUsecase {
  Future<Either<Failure, VigilanceEntity>> call(
      IncidentNearUserEntity incident);
}

class CreateIncidentUsecase implements ICreateIncidentUsecase {
  final IVigilanceRepository repository;

  CreateIncidentUsecase({required this.repository});

  @override
  Future<Either<Failure, VigilanceEntity>> call(
      IncidentNearUserEntity incident) async {
    return await repository.createIncident(incident);
  }
}
