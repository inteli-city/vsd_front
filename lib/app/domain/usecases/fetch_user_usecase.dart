import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_template/app/domain/entities/user_entity.dart';
import 'package:flutter_clean_architecture_template/app/domain/repositories/user_repository.dart';
import 'package:flutter_clean_architecture_template/app/domain/failures/failures.dart';

abstract class IFetchUserUsecase {
  Future<Either<Failure, UserEntity>> call();
}

class FetchUserUsecase implements IFetchUserUsecase {
  final IUserRepository repository;

  FetchUserUsecase({required this.repository});

  @override
  Future<Either<Failure, UserEntity>> call() async {
    return await repository.getUser();
  }
}
