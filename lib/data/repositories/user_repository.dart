import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> saveUserData({
    required String firstName,
    required String lastName,
    required DateTime dateOfBirth,
    required double weight,
    required double height,
  }) async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'firstName': firstName,
          'lastName': lastName,
          'dateOfBirth': dateOfBirth.toIso8601String(),
          'weight': weight,
          'height': height,
          'onboardingCompleted': true,
        }, SetOptions(merge: true));
      }
    } catch (e) {
      throw Exception("Failed to save user data");
    }
  }

  Future<bool> isOnboardingCompleted() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        final doc = await _firestore.collection('users').doc(user.uid).get();
        return doc.exists && (doc.data()?['onboardingCompleted'] ?? false);
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
