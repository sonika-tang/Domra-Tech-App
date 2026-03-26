import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../core/config/constants.dart';

class FirebaseStorageService {
  Future<String?> uploadImage(XFile imageFile, String folderPath) async {
    try {
      // Get signed URL from backend
      final res = await http.post(Uri.parse('$baseUrl/upload-url'));
      if (res.statusCode != 200) {
        print('Error getting upload url: ${res.body}');
        return null;
      }
      final data = jsonDecode(res.body);
      final uploadUrl = data['uploadUrl'];
      final fileUrl = data['fileUrl'];

      // Upload bytes to signed URL
      final bytes = await imageFile.readAsBytes();
      final uploadRes = await http.put(
        Uri.parse(uploadUrl),
        headers: {'Content-Type': 'image/png'},
        body: bytes,
      );

      if (uploadRes.statusCode == 200) {
        return fileUrl;
      } else {
        print('Upload failed: ${uploadRes.statusCode} - ${uploadRes.body}');
        return null;
      }
    } catch (e) {
      print('Error uploading image to backend: $e');
      return null;
    }
  }
}
