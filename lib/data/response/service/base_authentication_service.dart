import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';

import '../../../model/profile_model.dart';

/// Abstract base class defining authentication-related operations.
abstract class BaseAuthenticationService {

  /// Returns the currently signed-in Firebase user, or null if none.
  User? getCurrentUser();
  
  Future<UserCredential> signInWithEmailAndPassword(
      {required String email, required String password});
  Future<UserCredential?> signWithGoogle();
  Future<bool> userExists();
  Future<void> createNewUserWithGoogle(
      {required User user, required ProfileModel profileModel});

  Future<String> uploadUserImageUrl({required File file});
  Future<UserCredential> createUserWithEmilandPassword(
      {required String email, required String password});
  Future<void> uploadUserProfile(
      {required ProfileModel profileModel, required String firebaseDocument});

  Future<void> forgetPasswordSnapshot({required String email});

  Future<void> signOutApp();
}
