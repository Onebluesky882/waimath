import 'package:waimath/auth/domain/entities/user.dart';
import 'package:waimath/auth/domain/repository/auth_repository.dart';

class LoginUsecase {
  final AuthRepository repository;

  LoginUsecase({required this.repository});

  Future<User> call(String email, String password) {
    return repository.login(email, password);
  }
}
