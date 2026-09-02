import '../models/user_profile_model.dart';
import '../services/profile_service.dart';

class ProfileController {

  static Stream<UserProfileModel?> getProfile(
      String uid) {

    return ProfileService.getProfile(uid);
  }

  static Future<void> saveProfile(
      UserProfileModel profile) {

    return ProfileService.saveProfile(profile);
  }
}