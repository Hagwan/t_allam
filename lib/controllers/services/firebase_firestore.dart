import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseFirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // CRUD operations

  // Create a new document and return true if successful or false if failed
  Future<bool> create({required String collection, required Map<String, dynamic> data}) async {
    try {
      data['uid'] = _firestore.collection(collection).doc().id;
      await _firestore.collection(collection).doc(data['uid']).set(data);
      return true;
    } catch (e) {
      return false;
    }
  }

  // Update a document and return true if successful or false if failed
  Future<bool> update({required String collection, required Map<String, dynamic> data}) async {
    try {
      await _firestore.collection(collection).doc(data['uid']).update(data);
      return true;
    } catch (e) {
      return false;
    }
  }

  // Delete a document and return true if successful or false if failed
  Future<bool> delete({required String collection, required String uid}) async {
    try {
      await _firestore.collection(collection).doc(uid).delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  // Get a document and return the data if successful or null if failed
  Future<Map<String, dynamic>?> get({required String collection, required String uid}) async {
    try {
      final document = await _firestore.collection(collection).doc(uid).get();
      return document.data();
    } catch (e) {
      return null;
    }
  }

  // Get all documents in a collection and return the data if successful or null if failed
  Future<List<dynamic>>? read({required String collection}) {
    try {
      return _firestore.collection(collection).get().then((QuerySnapshot querySnapshot) {
        return querySnapshot.docs.map((DocumentSnapshot document) => document.data()).toList();
      });
    } catch (e) {
      return null;
    }
  }
}
