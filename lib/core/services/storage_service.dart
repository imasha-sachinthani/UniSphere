import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  static final storage = FirebaseStorage.instance;

  static Future<String> uploadImage(
      File file,
      String folder,
      ) async {
    try {
      final fileName =
          "${DateTime.now().millisecondsSinceEpoch}.jpg";

      final ref = storage.ref("$folder/$fileName");

      log("Uploading to: ${ref.fullPath}");

      final task = await ref.putFile(file);

      log("Upload State: ${task.state}");

      final url = await ref.getDownloadURL();

      log("Download URL: $url");

      return url;
    } on FirebaseException catch (e) {
      log("Firebase Storage Error");
      log("Code : ${e.code}");
      log("Message : ${e.message}");

      rethrow;
    } catch (e) {
      log("Unknown Error : $e");
      rethrow;
    }
  }
}