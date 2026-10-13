import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class AssignmentFileService {
  static const String cloudName = "n2e4e0vh";
  static const String uploadPreset = "unisphere_upload";

  static const String uploadUrl =
      "https://api.cloudinary.com/v1_1/n2e4e0vh/raw/upload";

  /// Pick file from device and upload
  static Future<Map<String, String>?> pickAndUploadFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      withData: true,
      allowedExtensions: [
        "pdf",
        "doc",
        "docx",
        "ppt",
        "pptx",
        "zip",
      ],
    );

    if (result == null) return null;

    final picked = result.files.single;

    final request = http.MultipartRequest(
      "POST",
      Uri.parse(uploadUrl),
    );

    request.fields["upload_preset"] = uploadPreset;

    request.files.add(
      http.MultipartFile.fromBytes(
        "file",
        picked.bytes!,
        filename: picked.name,
      ),
    );

    final response = await request.send();

    if (response.statusCode != 200) {
      throw Exception("Cloudinary upload failed.");
    }

    final body = await response.stream.bytesToString();

    final json = jsonDecode(body);

    return {
      "url": json["secure_url"],
      "name": picked.name,
    };
  }

  /// Upload existing file (Submission)
  static Future<Map<String, String>?> uploadFile(
      File file) async {
    final request = http.MultipartRequest(
      "POST",
      Uri.parse(uploadUrl),
    );

    request.fields["upload_preset"] = uploadPreset;

    request.files.add(
      await http.MultipartFile.fromPath(
        "file",
        file.path,
      ),
    );

    final response = await request.send();

    if (response.statusCode != 200) {
      throw Exception("Cloudinary upload failed.");
    }

    final body = await response.stream.bytesToString();

    final json = jsonDecode(body);

    return {
      "url": json["secure_url"],
      "name": file.path.split("/").last,
    };
  }

  /// Upload assignment PDF from assets
  static Future<Map<String, String>> uploadAssetPdf() async {
    final data = await rootBundle.load(
      "assets/assignments/Software_Process_management_Assignment_01.pdf",
    );

    final bytes = data.buffer.asUint8List();

    final request = http.MultipartRequest(
      "POST",
      Uri.parse(uploadUrl),
    );

    request.fields["upload_preset"] = uploadPreset;

    request.files.add(
      http.MultipartFile.fromBytes(
        "file",
        bytes,
        filename:
        "Software_Process_management_Assignment_01.pdf",
        contentType: MediaType(
          "application",
          "pdf",
        ),
      ),
    );

    final response = await request.send();

    if (response.statusCode != 200) {
      throw Exception(
        "Assignment upload failed.",
      );
    }

    final body = await response.stream.bytesToString();

    final json = jsonDecode(body);

    return {
      "url": json["secure_url"],
      "name":
      "Software_Process_management_Assignment_01.pdf",
    };
  }
}