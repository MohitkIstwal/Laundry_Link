
import 'package:cloud_firestore/cloud_firestore.dart';

class FetchData{

  Future<Map<String, dynamic>> fetchUserById(String userId) async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (!doc.exists) {
        return {}; // ✅ Return an empty map if user does not exist
      }

      return doc.data() as Map<String, dynamic>; // ✅ Safe casting
    } catch (e) {
      print("Error fetching user: $e"); // ✅ Print error for debugging
      return {}; // ✅ Return an empty map on failure
    }
  }
}
