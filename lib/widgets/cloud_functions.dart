import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final String uid = FirebaseAuth.instance.currentUser.uid;
  Map<String, dynamic> userData = {};

  Future<Map<String, dynamic>> getUserData() async {
    return userData = await FirebaseFirestore.instance
        .collection('aktivere')
        .doc(uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      // print(documentSnapshot.data());
      return documentSnapshot.data();
    });
  }

  // DocumentReference get userData {
  //   return FirebaseFirestore.instance.collection('aktivere').doc('uid');
  // }

  final CollectionReference mvpAktiUsers =
      FirebaseFirestore.instance.collection('aktivere');

  Future updateUserData(
      String navn, String brukerEpost, bool isCompanyUser) async {
    return await mvpAktiUsers.doc(uid).set({
      'navn': navn,
      'brukerEpost': brukerEpost,
      'isCompanyUser': isCompanyUser,
    });
  }

  Future deleteUserData(String userUid) async {
    return await mvpAktiUsers.doc(userUid).delete();
  }
}
