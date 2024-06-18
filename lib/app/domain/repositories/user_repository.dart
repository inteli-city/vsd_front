import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_template/app/domain/entities/user_entity.dart';
import 'package:flutter_clean_architecture_template/app/domain/failures/failures.dart';

abstract class IUserRepository {
  Future<Either<Failure, UserEntity>> getUser();
}
