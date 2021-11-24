import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageHelper {
  /// Upload `File` and return `downloadURL`
  Future<String?> uploadFile(File file,
      {String path = "food", String? filename, String ext = "jpg"}) async {
    filename = filename ?? DateTime.now().toIso8601String();
    var ref = FirebaseStorage.instance
        .ref()
        .child(path)
        .child("$filename" + "." + ext);
    await ref.putFile(file);
    return await ref.getDownloadURL();
  }
}
