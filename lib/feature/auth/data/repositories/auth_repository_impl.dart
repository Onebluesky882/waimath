import 'package:waimath/feature/auth/data/datasources/remote_data_source.dart';

import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final RemoteDataSource remoteDataSource;
  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<User> login(String email, String password) async {
    // 1. เรียก API
    final userModel = await remoteDataSource.login(email, password);
    // 2. ส่งกลับเป็น User (Entity) ให้ Domain สบายใจ
    return userModel;
  }
}
