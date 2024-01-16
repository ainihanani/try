import 'package:firebase_auth/firebase_auth.dart';

class UserServices {
  static Future<void> updateProfile(String displayName, String s) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.updateDisplayName(displayName);
        print('User profile updated successfully!');
      } else {
        print('User not signed in.');
      }
    } catch (e) {
      print('Error updating user profile: $e');
    }
  }

  static Future<void> updateEmail(String newEmail) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.updateEmail(newEmail);
        print('User email updated successfully!');
      } else {
        print('User not signed in.');
      }
    } catch (e) {
      print('Error updating user email: $e');
    }
  }

  static Future<void> updatePassword(String newPassword) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.updatePassword(newPassword);
        print('User password updated successfully!');
      } else {
        print('User not signed in.');
      }
    } catch (e) {
      print('Error updating user password: $e');
    }
  }
}
