import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Database {
  FirebaseFirestore? firestore;
  initliase() {
    firestore = FirebaseFirestore.instance;
  }

  Future<void> createUser(String cellphone, String email, String names) async {
    try {
      await firestore!.collection('clients').add({
        'cellphone': cellphone,
        'createdAt': DateTime.now(),
        'email': email,
        'names': names
      });
    } catch (e) {}
  }

  static Future<bool> checkExist(String docID) async {
    bool exist = true;
    try {
      await FirebaseFirestore.instance
          .collection('clients')
          .where('email', isEqualTo: docID)
          .get()
          .then((doc) {
        if (doc.docs.length != 0) {
          exist = true;
        } else {
          exist = false;
        }
      });
      return exist;
    } catch (e) {
      // If any error
      return false;
    }
  }

  static Future<void> getID(email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      await FirebaseFirestore.instance
          .collection('clients')
          .where('email', isEqualTo: email)
          .get()
          .then((doc) async {
        if (doc.docs.length != 0) {
          await prefs.setString('id_client', doc.docs[0].id);
        }
      });
    } catch (e) {
      // If any error

    }
  }
}
