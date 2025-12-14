import 'package:waimath/auth/data/data_source/remote_data_source.dart';
import 'package:waimath/auth/domain/Repository/auth_repository.dart';
import 'package:waimath/auth/domain/entities/user.dart';

class AuthRepositoryImpl implements AuthRepository {
  final RemoteDataSource remoteDataSource;
  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<User> login(String email, String password) async {
    final userModel = await remoteDataSource.login(email, password);

    return userModel.toEntity();
  }
}
