import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDatabase {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static Future<void> post(
      {required String reference,
      required String doc,
      required dynamic data}) async {
    return await firestore
        .collection(reference)
        .doc(doc)
        .set(data)
        .catchError((error) => print(error));
  }

  static Future<void> put(
      {required String reference,
      required String doc,
      required dynamic data}) async {
    return await firestore
        .collection(reference)
        .doc(doc)
        .update(data)
        .catchError((error) => print(error));
  }

  static Future<dynamic> getSingle(
      {required String collection, String? itemId}) async {
    print(itemId);
    var dataSnapshot =
        await firestore.collection(collection).doc(itemId!).get();
    Map<String, dynamic> data = dataSnapshot.data()!;
    print(data);
    return data;
  }

  static Future<DocumentSnapshot<Map<String, dynamic>>> documentSnapshot(
      {required String collection, required String itemId}) async {
    return await firestore.collection(collection).doc(itemId).get();
  }

  static CollectionReference get({required String reference}) {
    return firestore.collection(reference);
  }
}
