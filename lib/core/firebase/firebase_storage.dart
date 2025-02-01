import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  final FirebaseStorage _storage;

  FirebaseStorageService(this._storage);

  Future<String?> uploadProfileImage(
      File imageFile, String userId, String child) async {
    try {
      final extaionIamge = imageFile.path.split(".").last;
      final path = '$child/$userId.$extaionIamge';
      final ref = _storage.ref().child(path);
      UploadTask uploadTask = ref.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      throw Exception("Image Upload Error: $e");
    }
  }
}
