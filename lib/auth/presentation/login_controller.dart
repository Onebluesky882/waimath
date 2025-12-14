import 'package:waimath/auth/domain/entities/user.dart';
import 'package:waimath/auth/domain/usecases/login_usecase.dart';

class LoginController {
  final LoginUsecase loginUsecase;

  LoginController({required this.loginUsecase});

  Future<User> login(String email, String password) async {
    return await loginUsecase(email, password);
  }
}

// สืบคลาสกันเรื่อยๆๆ
