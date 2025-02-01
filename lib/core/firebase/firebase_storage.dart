import 'dart:io';
import 'package:flutter/foundation.dart'; // For kIsWeb
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseStorageService {
  final FirebaseStorage _storage;

  FirebaseStorageService(this._storage);

  Future<String?> uploadProfileImage(XFile imageFile, String userId, String child) async {
    try {
      // Generate a unique filename
      String fileExtension = imageFile.path.split('.').last; // Get file extension
      String fileName = "${userId}_${DateTime.now().millisecondsSinceEpoch}.$fileExtension";

      // Create a storage reference
      Reference ref = _storage.ref().child('$child/$fileName');

      UploadTask uploadTask;

      if (kIsWeb) {
        // Web: Convert image to bytes and upload
        Uint8List imageBytes = await imageFile.readAsBytes();
        uploadTask = ref.putData(imageBytes, SettableMetadata(contentType: 'image/$fileExtension'));
      } else {
        // Mobile: Use File for upload
        File file = File(imageFile.path);
        uploadTask = ref.putFile(file, SettableMetadata(contentType: 'image/$fileExtension'));
      }

      // Wait for upload to complete
      TaskSnapshot snapshot = await uploadTask;

      // Get and return the download URL
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      throw Exception("🔥 Image Upload Error: $e");
    }
  }
}
