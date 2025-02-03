import 'package:get_it/get_it.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/data/sources/auth_remote_data_source.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'features/auth/domain/usecases/sign_in.dart';
import 'features/auth/domain/usecases/sign_up.dart';

final sl = GetIt.instance;

void init() {
  // Registrar las dependencias

  // Registra la implementación concreta de AuthRepository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));

  // Registra la fuente de datos remota
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl());

  // Registrar casos de uso
  sl.registerLazySingleton(() => SignIn(sl()));

  // Registrar casos de uso de sign up
  sl.registerLazySingleton(() => SignUp(sl()));

  // Registrar Cubit
  sl.registerFactory(() => AuthCubit(sl(), sl()));
}
