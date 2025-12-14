import 'package:waimath/auth/domain/entities/user.dart';
import 'package:waimath/auth/domain/repository/auth_repository.dart';

class LoginUseCase {
  final AuthRepository authRepository;
  LoginUseCase({required this.authRepository});

  Future<User> call(String email, String password) {
    return authRepository.login(email, password);
  }
}
