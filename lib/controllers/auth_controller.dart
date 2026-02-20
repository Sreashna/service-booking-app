import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../bottom/mainscreen.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var isLoading = false.obs;

  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;

      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.offAll(() => const MainHomeScreen());

    } catch (e) {
      Get.snackbar("Login Failed", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signup(String email, String password) async {
    try {
      isLoading.value = true;

      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      Get.snackbar(
        "Success",
        "Account created successfully. Please login.",
      );
      Get.back();

    } catch (e) {
      Get.snackbar("Signup Failed", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}