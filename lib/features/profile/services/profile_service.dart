import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_profile_model.dart';

class ProfileService {

  static final collection =
  FirebaseFirestore.instance.collection("users");

  static Stream<UserProfileModel?> getProfile(
      String uid) {

    return collection.doc(uid).snapshots().map((doc) {

      if (!doc.exists) return null;

      return UserProfileModel.fromFirestore(doc);

    });
  }

  static Future<void> saveProfile(
      UserProfileModel profile) async {

    await collection
        .doc(profile.uid)
        .set(profile.toMap());
  }
}