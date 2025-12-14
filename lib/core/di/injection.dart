import 'package:supabase_flutter/supabase_flutter.dart' as sb;
import 'package:waimath/auth/data/data_source/supabase_auth.dart';
import 'package:waimath/auth/data/repository/auth_repository_impl.dart';
import 'package:waimath/auth/domain/usecases/login_usecase.dart';
import 'package:waimath/auth/presentation/login_controller.dart';

LoginController makeLoginController() {
  return LoginController(
    loginUsecase: LoginUsecase(
      repo: AuthRepositoryImpl(
        supabaseRemoteSource: SupabaseRemoteSource(
          supabase: sb.Supabase.instance.client,
        ),
      ),
    ),
  );
}
