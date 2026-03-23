import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class FirebaseStorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String?> uploadImage(XFile imageFile, String folderPath) async {
    try {
      final String fileName = '${DateTime.now().millisecondsSinceEpoch}_${imageFile.name}';
      final Reference ref = _storage.ref().child('$folderPath/$fileName');

      UploadTask uploadTask;
      if (kIsWeb) {
        final bytes = await imageFile.readAsBytes();
        uploadTask = ref.putData(bytes, SettableMetadata(contentType: 'image/jpeg'));
      } else {
        uploadTask = ref.putFile(File(imageFile.path));
      }
      
      final TaskSnapshot snapshot = await uploadTask;
      final String downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      print('Error uploading image to Firebase Storage: $e');
      return null;
    }
  }
}
