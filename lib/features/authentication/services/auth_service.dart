import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  AuthService._();

  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  static Future<UserCredential> register({
    required String fullName,
    required String email,
    required String password,
  }) async {

    final credential =
    await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = credential.user;

    if (user != null) {

      await _firestore
          .collection("profiles")
          .doc(user.uid)
          .set({

        "uid": user.uid,

        "fullName": fullName,

        "email": email,

        "phone": "",

        "faculty": "",

        "year": "",

        "imageUrl": "",

        "createdAt":
        FieldValue.serverTimestamp(),
      });
    }

    return credential;
  }

  static Future<UserCredential> login({
    required String email,
    required String password,
  }) async {

    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  static Future<void> forgotPassword(
      String email) async {

    await _auth.sendPasswordResetEmail(
      email: email,
    );
  }

  static Future<void> logout() async {
    await _auth.signOut();
  }

  static User? get currentUser =>
      _auth.currentUser;

  static Stream<User?> get authStateChanges =>
      _auth.authStateChanges();
}