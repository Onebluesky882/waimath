import 'package:supabase_flutter/supabase_flutter.dart' as sb;
import 'package:waimath/feature/auth/data/datasources/remote_data_source.dart';
import 'package:waimath/feature/auth/domain/entities/user.dart';

class SupabaseRemoteDataSourceImpl implements RemoteDataSource {
  final sb.SupabaseClient supabase;

  SupabaseRemoteDataSourceImpl(this.supabase);

  @override
  Future<User> login(String email, String password) async {
    final response = await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );

    final supabaseUser = response.user;
    if (supabaseUser == null) {
      throw Exception('login fail');
    }
    return User(id: supabaseUser.id, email: supabaseUser.email ?? "");
  }
}
