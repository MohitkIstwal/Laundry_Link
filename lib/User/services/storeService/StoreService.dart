import 'package:cloud_firestore/cloud_firestore.dart';

class StoreService{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Map<String,dynamic>>> getStoreList(){
    return _firestore.collection("staff").snapshots().map((snapshot){
      return snapshot.docs.map((doc){
        final user = doc.data();
        return user;
      }).toList();
    });
  }
}