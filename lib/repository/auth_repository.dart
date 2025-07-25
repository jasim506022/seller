import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';

import '../data/response/app_data_exception.dart';
import '../data/response/service/data_authentication_service.dart';
import '../model/profile_model.dart';
import '../res/app_function.dart';

class AuthRepository {
  final FirebaseAuthenticationService _authService = FirebaseAuthenticationService();

  /// Signs in a user using their email and password.
  Future<UserCredential> loginWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      return await _authService.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      AppsFunction.handleException(e);
      rethrow;
    }
  }

  /// Signs in a user using their Google account.
  Future<UserCredential?> loginWithGoogle() async {
    try {
      return await _authService.signWithGoogle();
    } catch (e) {
      AppsFunction.handleException(e);
      rethrow;
    }
  }

  /// Checks if a user profile exists in Firestore.
  Future<bool> isUserProfileExists() async {
    try {
      return await _authService.userExists();
    } catch (e) {
      AppsFunction.handleException(e);
      rethrow;
    }
  }

  /// Creates a new user profile in Firestore using Google credentials.
  Future<void> createNewUserWithGoogle(
      {required User user, required ProfileModel profileModel}) async {
    try {
      await _authService.createNewUserWithGoogle(
          user: user, profileModel: profileModel);
    } catch (e) {
      AppsFunction.handleException(e);
    }
  }

  ///  Uploads a user image to Firebase Storage and returns the download URL.
  ///
  /// Takes a [file] to upload, and an optional [isProfile] flag to specify
  /// if the image is a profile picture. Delegates the actual upload to
  /// [_authService.uploadUserImageUrl].
  Future<String> uploadUserImage(
      {required File file, bool isProfile = false}) async {
    try {
      return _authService.uploadUserImageUrl(file: file, isProfile: isProfile);
    } catch (e) {
      AppsFunction.handleException(e);
      rethrow;
    }
  }

  /// Creates a new user account with an email and password.
  Future<UserCredential> registerUserWithEmailAndPassword(
      {required String email, required String password}) {
    try {
      return _authService.createUserWithEmilandPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      AppsFunction.handleException(e);
      rethrow;
    } catch (e) {
      AppsFunction.handleException(e);
      throw OthersException(e.toString());
    }
  }

  /// Updates or creates a user profile in Firestore.

  Future<void> saveUserProfile(
      {required ProfileModel profileModel, required String documentId}) async {
    try {
      _authService.uploadUserProfile(
          profileModel: profileModel, firebaseDocument: documentId);
    } catch (e) {
      AppsFunction.handleException(e);
      rethrow;
    }
  }

  /// Sends a password reset email to the provided email address.
  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await _authService.forgetPasswordSnapshot(email: email);
    } catch (e) {
      AppsFunction.handleException(e);
    }
  }


  /// Signs the user out of the application
  Future<void> signOut() async {
    try {
      await _authService.signOutApp();
    } catch (e) {
      AppsFunction.handleException(e);
    }
  }
}
