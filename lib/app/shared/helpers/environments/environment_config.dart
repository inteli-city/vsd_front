// ignore_for_file: constant_identifier_names

import 'package:flutter_clean_architecture_template/app/data/repositories/user_mock_repository.dart';
import 'package:flutter_clean_architecture_template/app/data/repositories/vigilance_mock_repository.dart';
import 'package:flutter_clean_architecture_template/app/domain/repositories/user_repository.dart';
import 'package:flutter_clean_architecture_template/app/domain/repositories/vigilance_repository.dart';

class EnvironmentConfig {
  static const MSS_BASE_URL = String.fromEnvironment('MSS_BASE_URL');
  static const ENV = String.fromEnvironment(
    'ENV',
  );

  static IUserRepository getUserRepo() {
    // EnvironmentEnum value = EnvironmentEnum.values.firstWhere(
    //   (element) {
    //     return element.name.toUpperCase() == ENV.toUpperCase();
    //   },
    //   orElse: () => EnvironmentEnum.DEV,
    // );
    // if (value == EnvironmentEnum.DEV) {
    return UserMockRepository();
    // } else {
    //   return DioUserRepository();
    // }
  }

  static IVigilanceRepository getVigilanceRepo() {
    // EnvironmentEnum value = EnvironmentEnum.values.firstWhere(
    //   (element) {
    //     return element.name.toUpperCase() == ENV.toUpperCase();
    //   },
    //   orElse: () => EnvironmentEnum.DEV,
    // );
    // if (value == EnvironmentEnum.DEV) {
    return VigilanceMockRepository();
    // } else {
    //   return DioUserRepository();
    // }
  }
}
