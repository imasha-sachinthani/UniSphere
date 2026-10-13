import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class CloudinaryService {
  CloudinaryService._();

  static const String _cloudName = 'n2e4e0vh';
  static const String _uploadPreset = 'unisphere_upload';

  static final ImagePicker _picker = ImagePicker();

  static Future<String?> pickAndUploadImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );

      if (image == null) {
        return null;
      }

      return await uploadImage(File(image.path));
    } catch (e) {
      throw Exception('Image selection failed: $e');
    }
  }

  static Future<String?> uploadImage(File imageFile) async {
    try {
      final uri = Uri.parse(
        'https://api.cloudinary.com/v1_1/$_cloudName/image/upload',
      );

      final request = http.MultipartRequest(
        'POST',
        uri,
      );

      request.fields['upload_preset'] = _uploadPreset;

      request.files.add(
        await http.MultipartFile.fromPath(
          'file',
          imageFile.path,
        ),
      );

      final streamedResponse = await request.send();

      final response = await http.Response.fromStream(
        streamedResponse,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        return data['secure_url'];
      }

      throw Exception(
        'Upload failed\n${response.body}',
      );
    } catch (e) {
      throw Exception(
        'Cloudinary upload failed: $e',
      );
    }
  }
}