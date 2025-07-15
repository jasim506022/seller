import 'package:cloud_firestore/cloud_firestore.dart';

import '../data/response/service/data_profile_service.dart';
import '../res/app_function.dart';

class ProfileRepository {
  final dataService = DataProfileService();

  /// Retrieves the user's profile document from Firestore.
  ///
  /// Delegates the fetch operation to [dataService].
  /// Exceptions are caught and handled, then rethrown.
  Future<DocumentSnapshot<Map<String, dynamic>>> fetchUserProfile() async {
    try {
      return await dataService.fetchUserProfile();
    } catch (e) {
      AppsFunction.handleException(e);
      rethrow;
    }
  }

  /// Updates the authenticated user's Firestore document.
  ///
  /// Accepts a map of profile fields to update.
  Future<void> updateProfile({required Map<String, dynamic> profileData}) async {
    try {
      await dataService.updateProfile(profileData: profileData);
    } catch (e) {
      AppsFunction.handleException(e);
    }
  }
}
/*
 1. // Optionally: rethrow or return failure if needed
 */