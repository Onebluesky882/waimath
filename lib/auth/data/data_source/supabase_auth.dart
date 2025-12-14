import 'package:supabase_flutter/supabase_flutter.dart' as sb;
import 'package:waimath/auth/data/data_source/remote_data_source.dart';
import 'package:waimath/auth/data/model/user_model.dart';

class SupabaseRemoteSource implements RemoteDataSource {
  final sb.SupabaseClient supabase;
  SupabaseRemoteSource({required this.supabase});

  @override
  Future<UserModel> login(String email, String password) async {
    final response = await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );

    if (response.user == null) {
      throw Exception('login failed');
    }

    return UserModel(id: response.user!.id, email: response.user?.email ?? '');
  }
}
