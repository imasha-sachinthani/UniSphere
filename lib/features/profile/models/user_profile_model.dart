import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfileModel {
  final String uid;
  final String fullName;
  final String email;
  final String phone;
  final String faculty;
  final String year;
  final String imageUrl;

  UserProfileModel({
    required this.uid,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.faculty,
    required this.year,
    required this.imageUrl,
  });

  factory UserProfileModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return UserProfileModel(
      uid: doc.id,
      fullName: data["fullName"] ?? "",
      email: data["email"] ?? "",
      phone: data["phone"] ?? "",
      faculty: data["faculty"] ?? "",
      year: data["year"] ?? "",
      imageUrl: data["imageUrl"] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "fullName": fullName,
      "email": email,
      "phone": phone,
      "faculty": faculty,
      "year": year,
      "imageUrl": imageUrl,
    };
  }
}