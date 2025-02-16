import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class UserRepository {
  final FirebaseDatabase _firebaseDatabase = FirebaseDatabase.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> saveUserData({
    required String firstName,
    required String lastName,
    required DateTime dateOfBirth,
    required String weight,
    required String height,
  }) async {
    try {
      final user = _auth.currentUser?.uid;
      if (user != null) {
        await _firebaseDatabase.ref('users/$user').set({
          'firstName': firstName,
          'lastName': lastName,
          'dateOfBirth': dateOfBirth.toIso8601String(),
          'weight': weight,
          'height': height,
        });
      } else {
        throw Exception('User is not authenticated');
      }
    } catch (e) {
      rethrow;
    }
  }
}
