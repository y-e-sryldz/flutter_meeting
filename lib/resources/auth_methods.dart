import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meeting/utils/utils.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<User?> get authChanges => _auth.authStateChanges();

  User get user => _auth.currentUser!;

  Future<bool> signInWithGoogle(BuildContext context) async {
    bool res = false;
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        // Kullanıcı oturum açmayı iptal etti
        return false;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        // Kullanıcının Firestore'a kaydedilmesi
        final userDoc = _firestore.collection('users').doc(user.uid);

        if (!(await userDoc.get()).exists) {
          await userDoc.set({
            'username': user.displayName ?? '',
            'uid': user.uid,
            'profilePhoto': user.photoURL ?? '',
            'email': user.email ?? '',
            'createdAt': FieldValue.serverTimestamp(),
          });
        }
        res = true;
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      showSnackBar(context, e.message ?? "Bir hata oluştu.");
      res = false;
    } catch (e) {
      print(e);
      showSnackBar(context, e.toString());
      res = false;
    }
    return res;
  }

  void singOut() async {
    try {
      _auth.signOut();
    } catch (e) {
      print(e);
    }
  }
}
