import 'package:supabase_flutter/supabase_flutter.dart' as sb;
import 'package:waimath/auth/data/data_source/remote_data_source.dart';
import 'package:waimath/auth/data/model/user_model.dart';

//implementation
class SupabaseRemoteDataSourceImpl implements RemoteDataSource {
  final sb.SupabaseClient supabase;

  SupabaseRemoteDataSourceImpl({required this.supabase});
  @override
  Future<UserModel> login(String email, String password) async {
    final response = await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
    final sbUser = response.user;
    if (sbUser == null) {
      throw Exception('Login failed');
    }

    return UserModel(id: sbUser.id, email: sbUser.email ?? '');
  }
}
