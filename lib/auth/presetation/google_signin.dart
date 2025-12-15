// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// Future<AuthResponse> GoogleSignIn() async {
//   /// TODO: update the Web client ID with your own.
//   ///
//   /// Web Client ID that you registered with Google Cloud.
//   const webClientId = 'my-web.apps.googleusercontent.com';

//   /// TODO: update the iOS client ID with your own.
//   ///
//   /// iOS Client ID that you registered with Google Cloud.
//   const iosClientId = 'my-ios.apps.googleusercontent.com';

//   // Google sign in on Android will work without providing the Android
//   // Client ID registered on Google Cloud.

//   final GoogleSignIn signIn = GoogleSignIn.instance;

//   // Perform the sign in
//   final googleAccount = await signIn.authenticate();
//   final googleAuthorization = await googleAccount.authorizationClient
//       .authorizationForScopes([]);
//   final googleAuthentication = googleAccount!.authentication;
//   final idToken = googleAuthentication.idToken;
//   final accessToken = googleAuthorization.accessToken;

//   if (idToken == null) {
//     throw 'No ID Token found.';
//   }

//   return supabase.auth.signInWithIdToken(
//     provider: OAuthProvider.google,
//     idToken: idToken,
//     accessToken: accessToken,
//   );
// }
