import 'package:waimath/feature/auth/domain/entities/user.dart';

abstract class RemoteDataSource {
  Future<User> login(String email, String password);
}