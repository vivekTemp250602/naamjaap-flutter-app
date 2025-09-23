import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  /// Uploads a user's profile picture to Firebase Storage.
  /// Returns the public download URL of the uploaded image.
  Future<String> uploadProfilePicture(String uid, XFile imageFile) async {
    try {
      // Create a reference to the file's location.
      // We use a consistent file name to ensure a user only has one profile picture.
      Reference ref = _storage
          .ref()
          .child('profile_pictures')
          .child(uid)
          .child('profile.jpg');

      // Upload the file.
      UploadTask uploadTask = ref.putFile(File(imageFile.path));

      // Wait for the upload to complete.
      TaskSnapshot snapshot = await uploadTask;

      // Get the public download URL.
      String downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      print("Error uploading profile picture: $e");
      rethrow; // Rethrow the error to be handled by the UI
    }
  }
}
