import 'package:waimath/feature/auth/domain/entities/User.dart';

abstract class Repository {
  Future<User> login(String email, password);
  Future<User> signUpWithEmail(String email, password);
  Future<User> signGoogle(String email, password);
}
