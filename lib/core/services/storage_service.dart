import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {

  static final storage =
      FirebaseStorage.instance;

  static Future<String> uploadImage(
      File file,
      String folder,
      ) async {

    final fileName =
    DateTime.now().millisecondsSinceEpoch
        .toString();

    final ref = storage
        .ref()
        .child(folder)
        .child(fileName);

    await ref.putFile(file);

    return await ref.getDownloadURL();
  }
}