import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_template/app/domain/entities/vigilance_entity.dart';
import 'package:flutter_clean_architecture_template/app/domain/failures/failures.dart';
import 'package:flutter_clean_architecture_template/app/domain/repositories/vigilance_repository.dart';

abstract class IFetchVigilancesUsecase {
  Future<Either<Failure, VigilanceEntity>> call();
}

class FetchVigilancesUsecase implements IFetchVigilancesUsecase {
  final IVigilanceRepository repository;

  FetchVigilancesUsecase({required this.repository});

  @override
  Future<Either<Failure, VigilanceEntity>> call() async {
    return await repository.getVigilances();
  }
}
