import 'package:waimath/auth/data/data_source/supabase_remote_data_source.dart';
import 'package:waimath/auth/domain/entities/user.dart';
import 'package:waimath/auth/domain/repository/auth_repository.dart'
    show AuthRepository;

class AuthRepositoryImpl implements AuthRepository {
  final SupabaseRemoteDataSource supabaseRemoteDataSource;

  AuthRepositoryImpl({required this.supabaseRemoteDataSource});

  @override
  Future<User> login(String email, String password) async {
    final userModel = await supabaseRemoteDataSource.login(email, password);
    return userModel.toEntity();
  }
}
