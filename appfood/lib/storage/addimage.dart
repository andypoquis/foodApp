import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseApi {
  String? _url;

  static Future<UploadTask?> uploadFile(String destination, File file) async {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putFile(file);
    } on FirebaseException catch (e) {
      return null;
    }
  }

  static UploadTask? uploadBytes(String destination, Uint8List data) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);
      print('La Url es la siguiente ${ref.getDownloadURL()}');
      return ref.putData(data);
    } on FirebaseException catch (e) {
      return null;
    }
  }
}
