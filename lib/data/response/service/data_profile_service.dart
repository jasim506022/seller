import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../res/app_constants.dart';
import '../../../res/app_string.dart';
import 'base_profile_service.dart';

class DataProfileService extends BaseProfileService {
  final _firebaseFirestore = FirebaseFirestore.instance;

  /// **Fetch user profile from Firestore**
  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> fetchUserProfile() {
    return _firebaseFirestore
        .collection(AppStrings.collectionSeller)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
  }

  /// **Update user profile in Firestore**
  ///
  /// Updates the Firestore document of the current user with given profile data.
  @override
  Future<void> updateProfile({
    required Map<String, dynamic> profileData,
  }) async {
    final userId = AppConstants.sharedPreferences?.getString(
      AppStrings.prefUserId,
    );

    await _firebaseFirestore
        .collection(AppStrings.collectionSeller)
        .doc(userId)
        .update(profileData);
  }
}
