import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_template/app/data/models/user_model.dart';
import 'package:flutter_clean_architecture_template/app/domain/entities/user_entity.dart';
import 'package:flutter_clean_architecture_template/app/domain/repositories/user_repository.dart';
import 'package:flutter_clean_architecture_template/app/domain/failures/failures.dart';

class UserMockRepository implements IUserRepository {
  UserEntity user = const UserModel(
    userId: '53df5564-3777-4715-86b4-bb7855af695a',
    name: 'MARIO ROBERTO GAIA GATES',
    imageUrl: 'https://intelicity-assets.s3.sa-east-1.amazonaws.com/avatar.png',
    region: 'JARDIM PAULISTANO',
    adress: 'RUA PRUDENTE CORREIA',
    adressNumber: 215,
  );

  @override
  Future<Either<Failure, UserEntity>> getUser() async {
    return Right(user);
  }
}
