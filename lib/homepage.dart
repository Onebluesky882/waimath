import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

final supabase = Supabase.instance.client;

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String? _userId;

  @override
  void initState() {
    super.initState();
    supabase.auth.onAuthStateChange.listen((data) {
      _userId = data.session?.user.id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(_userId ?? 'not signed in'),
          ElevatedButton(
            onPressed: () async {
              /// Web Client ID that you registered with Google Cloud.
              const webClientId =
                  '369866099922-fqk4lngqq0id6suglmau4od9nlpteefg.apps.googleusercontent.com';

              /// iOS Client ID that you registered with Google Cloud.
              const iosClientId =
                  '369866099922-i2ep0oojijkdfjv5jvq03savis4rlfbu.apps.googleusercontent.com';
              final scopes = ['email', 'profile'];
              final googleSignIn = GoogleSignIn.instance;
              await googleSignIn.initialize(
                serverClientId: webClientId,
                clientId: iosClientId,
              );
              final googleUser = await googleSignIn
                  .attemptLightweightAuthentication();
              // or await googleSignIn.authenticate(); which will return a GoogleSignInAccount or throw an exception
              if (googleUser == null) {
                throw AuthException('Failed to sign in with Google.');
              }

              /// Authorization is required to obtain the access token with the appropriate scopes for Supabase authentication,
              /// while also granting permission to access user information.
              final authorization =
                  await googleUser.authorizationClient.authorizationForScopes(
                    scopes,
                  ) ??
                  await googleUser.authorizationClient.authorizeScopes(scopes);
              final idToken = googleUser.authentication.idToken;
              if (idToken == null) {
                throw AuthException('No ID Token found.');
              }
              await supabase.auth.signInWithIdToken(
                provider: OAuthProvider.google,
                idToken: idToken,
                accessToken: authorization.accessToken,
              );
            },

            child: Text('sign in with google'),
          ),
        ],
      ),
    );
  }
}
