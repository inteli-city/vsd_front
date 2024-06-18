import 'package:auto_injector/auto_injector.dart';
import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture_template/app/domain/repositories/vigilance_repository.dart';
import 'package:flutter_clean_architecture_template/app/domain/usecases/fetch_vigilances_usecase.dart';
import 'package:flutter_clean_architecture_template/app/presentation/stores/providers/vigilance_provider.dart';
import 'package:logger/logger.dart';
import 'package:flutter_clean_architecture_template/app/domain/repositories/user_repository.dart';
import 'package:flutter_clean_architecture_template/app/domain/usecases/fetch_user_usecase.dart';
import 'package:flutter_clean_architecture_template/app/presentation/stores/providers/user_provider.dart';
import 'package:flutter_clean_architecture_template/app/shared/helpers/environments/environment_config.dart';
import 'package:flutter_clean_architecture_template/app/shared/helpers/services/dio/dio_auth_interceptor.dart';
import 'package:flutter_clean_architecture_template/app/shared/helpers/services/dio/dio_http_service.dart';
import 'package:flutter_clean_architecture_template/app/shared/helpers/services/http_service.dart';

final injector = AutoInjector();

void registerInstances() {
  injector.addLazySingleton(Logger.new);
  injector.add<IHttpService>(DioHttpService.new);
  injector.addLazySingleton(VigilanceProvider.new);
  injector.addLazySingleton<Dio>(
    () => Dio(BaseOptions(baseUrl: EnvironmentConfig.MSS_BASE_URL))
      ..interceptors.addAll(
        [
          AuthInterceptor(),
        ],
      ),
  );

  // User
  injector.addLazySingleton(UserProvider.new);
  injector.addLazySingleton<IUserRepository>(
    () => EnvironmentConfig.getUserRepo(),
  );
  injector.addLazySingleton<IFetchUserUsecase>(FetchUserUsecase.new);

  // Vigilance
  injector.addLazySingleton(VigilanceProvider.new);
  injector.addLazySingleton<IVigilanceRepository>(
    () => EnvironmentConfig.getVigilanceRepo(),
  );
  injector
      .addLazySingleton<IFetchVigilancesUsecase>(FetchVigilancesUsecase.new);

  injector.commit();
}
