import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceList {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createServiceList(
      String text, storeName, StaffServiceModel) async {
    return await _firestore
        .collection(storeName)
        .doc(text)
        .set(StaffServiceModel.toMap());
  }

  Stream<List<Map<String, dynamic>>> getServiceList(String storeName) {
    return _firestore.collection(storeName).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }

  Stream<List<String>> getItemList(String storeName, String serviceName) {
    return _firestore
        .collection(storeName)
        .doc(serviceName)
        .snapshots()
        .map((snapshot) {
      final data = snapshot.data(); // Get document data
      if (data != null && data.containsKey('ItemList')) {
        return List<String>.from(
            data['ItemList']); // Extract 'ItemList' and return as List
      } else {
        return []; // Return empty list if 'ItemList' does not exist
      }
    });
  }

  Future<void> addServiceToStore(
      String storeName, serviceName, String newService) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    await db.collection(storeName).doc(serviceName).update({
      "ItemList": FieldValue.arrayUnion(
          [newService]) // Add new item without overwriting
    });
  }

  Future<void> removeServiceFromStore(
      String storeName, serviceName, String serviceToRemove) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    await db.collection(storeName).doc(serviceName).update({
      "ItemList":
          FieldValue.arrayRemove([serviceToRemove]) // Remove item from list
    });
  }
}
