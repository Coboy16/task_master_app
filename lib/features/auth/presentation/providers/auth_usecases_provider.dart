import 'package:riverpod_annotation/riverpod_annotation.dart';

import '/features/auth/domain/domain.dart';
import 'auth_dependencies_provider.dart';

part 'auth_usecases_provider.g.dart';

@Riverpod(keepAlive: true)
CheckAuthStatusUsecase checkAuthStatusUsecase(Ref ref) {
  return CheckAuthStatusUsecase(ref.watch(authRepositoryProvider));
}

@Riverpod(keepAlive: true)
LoginWithEmailUsecase loginWithEmailUsecase(Ref ref) {
  return LoginWithEmailUsecase(ref.watch(authRepositoryProvider));
}

@Riverpod(keepAlive: true)
RegisterWithEmailUsecase registerWithEmailUsecase(Ref ref) {
  return RegisterWithEmailUsecase(ref.watch(authRepositoryProvider));
}

@Riverpod(keepAlive: true)
CreateGuestUserUsecase createGuestUserUsecase(Ref ref) {
  return CreateGuestUserUsecase(ref.watch(authRepositoryProvider));
}

@Riverpod(keepAlive: true)
LogoutUsecase logoutUsecase(Ref ref) {
  return LogoutUsecase(ref.watch(authRepositoryProvider));
}

@Riverpod(keepAlive: true)
GetCurrentUserUsecase getCurrentUserUsecase(Ref ref) {
  return GetCurrentUserUsecase(ref.watch(authRepositoryProvider));
}

@Riverpod(keepAlive: true)
MigrateGuestToAuthUsecase migrateGuestToAuthUsecase(Ref ref) {
  return MigrateGuestToAuthUsecase(ref.watch(authRepositoryProvider));
}
