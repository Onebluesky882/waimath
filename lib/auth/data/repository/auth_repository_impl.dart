import 'package:waimath/auth/data/data_source/supabase_auth.dart';
import 'package:waimath/auth/domain/entities/user.dart';
import 'package:waimath/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final SupabaseRemoteSource supabaseRemoteSource;
  AuthRepositoryImpl({required this.supabaseRemoteSource});

  @override
  Future<User> login(String email, String password) async {
    final userModel = await supabaseRemoteSource.login(email, password);

    return userModel.toEntity();
  }
}
