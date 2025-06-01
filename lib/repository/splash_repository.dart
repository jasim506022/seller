import 'package:firebase_auth/firebase_auth.dart';

import '../data/response/service/data_authentication_service.dart';
import '../res/app_function.dart';

/// Handles authentication-related data for the splash screen.
class SplashRepository {
  // Instance of Firebase service to get user data.
  final  FirebaseAuthenticationService firebaseAuthenticationService = FirebaseAuthenticationService();

  /// Fetches the currently logged-in user from Firebase.
  User? getCurrentUser() {
    try {
      return firebaseAuthenticationService.getCurrentUser();
    } catch (e) {
      AppsFunction.handleException(e);
      rethrow;
    }
  }
}
