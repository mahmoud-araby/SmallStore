import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

mixin FirebaseUploader {
  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: "gs://flutterstore-c3a00.appspot.com");
  StorageUploadTask uploadTask;

  uploadImage(File image) async {
    String path = 'images/${DateTime.now()}.png';
    uploadTask = _storage.ref().child(path).putFile(image);
    while (uploadTask.isInProgress) {
      print(uploadTask.lastSnapshot.bytesTransferred);
    }
    if (uploadTask.isSuccessful) {
      StorageTaskSnapshot data = await uploadTask.onComplete;
      print(data.uploadSessionUri.toFilePath());
    }
  }
}
