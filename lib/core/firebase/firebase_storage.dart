import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class FirebaseStorageService {

  final FirebaseStorage _storage;

  FirebaseStorageService(this._storage);

  Future<String?> uploadFile({
    required File file,
    required String userId,
    required String pathchild,
  }) async {
    try {

      String extensionImage = file.path.contains('.')
          ? file.path.split('.').last
          : 'jpg';


      final String path = '$pathchild/${Uuid().v1()}.$extensionImage';

      final ref = _storage.ref().child(path);

      UploadTask uploadTask = ref.putFile(file);

      var snapshot = await uploadTask;

      if (snapshot.state == TaskState.success) {
        return await ref.getDownloadURL();
      } else {
        throw Exception("Upload failed, please try again.");
      }
    } catch (e) {
      throw Exception("Image Upload Error: $e");
    }
  }
}
