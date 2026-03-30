import 'dart:convert';
import 'dart:io' show File;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class FirebaseStorageService {
  Future<String?> uploadImage(XFile imageFile, String folder) async {
    try {
      final storageRef = FirebaseStorage.instance.ref();
      final imagesRef = storageRef.child(
        "$folder/${DateTime.now().millisecondsSinceEpoch}.png",
      );

      if (kIsWeb) {
        // Web: use putData
        final bytes = await imageFile.readAsBytes();
        await imagesRef.putData(bytes);
      } else {
        // Mobile/Desktop: use putFile
        await imagesRef.putFile(File(imageFile.path));
      }

      final downloadUrl = await imagesRef.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print("Upload failed: $e");
      return null;
    }
  }
}


Future<void> handleLoginResponse(String backendJwt) async {
  final storage = const FlutterSecureStorage();

  // Save the JWT itself
  await storage.write(key: 'jwt', value: backendJwt);

  // Decode payload to extract userId
  final parts = backendJwt.split('.');
  if (parts.length != 3) throw Exception("Invalid JWT format");

  final payload = utf8.decode(base64Url.decode(base64Url.normalize(parts[1])));
  final Map<String, dynamic> payloadMap = jsonDecode(payload);

  final userId = payloadMap['userId'];
  if (userId != null) {
    await storage.write(key: 'userId', value: userId.toString());
  }
}
