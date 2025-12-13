import 'package:waimath/feature/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<User> login(String email, String password);
}
