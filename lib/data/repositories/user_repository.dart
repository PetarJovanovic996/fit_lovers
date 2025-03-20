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

  Future<List<String>> getFavourites() async {
    try {
      final user = _auth.currentUser?.uid;
      if (user != null) {
        final myFavourites =
            await _firebaseDatabase.ref('users/$user/favourites').get();
        if (myFavourites.exists) {
          return List<String>.from(myFavourites.value as List);
        } else {
          return [];
        }
      } else {
        throw Exception('User is not authenticated');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> toggleFavourite(String exerciseName) async {
    try {
      final user = _auth.currentUser?.uid;
      if (user != null) {
        final favouritesRef = _firebaseDatabase.ref('users/$user/favourites');
        final myFavourites = await favouritesRef.get();
        List<String> favourites = myFavourites.exists
            ? List<String>.from(myFavourites.value as List)
            : [];

        if (favourites.contains(exerciseName)) {
          favourites.remove(exerciseName);
        } else {
          favourites.add(exerciseName);
        }

        await favouritesRef.set(favourites);
      } else {
        throw Exception('User is not authenticated');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<String>> getCompleted() async {
    try {
      final user = _auth.currentUser?.uid;
      if (user != null) {
        final myCompleted =
            await _firebaseDatabase.ref('users/$user/completed').get();
        if (myCompleted.exists) {
          return List<String>.from(myCompleted.value as List);
        } else {
          return [];
        }
      } else {
        throw Exception('User is not authenticated');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addCompleted(String exerciseName) async {
    try {
      final user = _auth.currentUser?.uid;
      if (user != null) {
        final completedRef = _firebaseDatabase.ref('users/$user/completed');
        final myCompleted = await completedRef.get();
        List<String> completed = myCompleted.exists
            ? List<String>.from(myCompleted.value as List)
            : [];

        if (!completed.contains(exerciseName)) {
          completed.add(exerciseName);
          await completedRef.set(completed);
        }
      } else {
        throw Exception('User is not authenticated');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> removeCompleted(String exerciseName) async {
    try {
      final user = _auth.currentUser?.uid;
      if (user != null) {
        final completedRef = _firebaseDatabase.ref('users/$user/completed');
        final myCompleted = await completedRef.get();
        List<String> completed = myCompleted.exists
            ? List<String>.from(myCompleted.value as List)
            : [];

        if (completed.contains(exerciseName)) {
          completed.remove(exerciseName);
          await completedRef.set(completed);
        }
      } else {
        throw Exception('User is not authenticated');
      }
    } catch (e) {
      rethrow;
    }
  }
}
