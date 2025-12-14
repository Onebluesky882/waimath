import 'package:waimath/auth/domain/entities/user.dart';
import 'package:waimath/auth/domain/repository/auth_repository.dart';

class LoginUsecase {
  final AuthRepository repo;

  LoginUsecase({required this.repo});

  Future<User> call(String email, String password) {
    return repo.login(email, password);
  }
}
