import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  Future<void> _handleGoogleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        // user batal login
        Get.snackbar('Login cancelled', 'User cancelled Google sign-in');
        return;
      }
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final String? token = googleAuth.idToken;
      if (token == null) {
        Get.snackbar('Error', 'Failed to get Google ID token');
        return;
      }

      // Kirim token ke controller (yang akan ke API lokal)
      await Get.find<LoginController>().signInWithGoogle(token);
    } catch (e) {
      Get.snackbar('Error', 'Login gagal: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LoginView'),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _handleGoogleSignIn,
          child: const Text('Login with Google'),
        ),
      ),
    );
  }
}
