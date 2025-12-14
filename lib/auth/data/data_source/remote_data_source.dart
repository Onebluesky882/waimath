import 'package:waimath/auth/data/model/user_model.dart';

// interface
abstract class RemoteDataSource {
  Future<UserModel> login(String email, String password);
}
