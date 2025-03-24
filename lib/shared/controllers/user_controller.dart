import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

class UserController extends GetxController {
  final isLogged = false.obs;
  final uid = ''.obs;
  final emailUsr = ''.obs;
  final verifiedMail = false.obs;
  final displayName = ''.obs;
  final initials = ''.obs;
  final photoURL = ''.obs;
  final photoUint = Uint8List(0).obs;
  final photoName = ''.obs;
  final phoneNumber = ''.obs;

  final nameController = TextEditingController(text: 'Gustavo Falavigna');
  final emailController = TextEditingController(text: 'gfalav@yahoo.com');
  final passwordController = TextEditingController(text: 'pppppppp');
  final repasswordController = TextEditingController(text: 'pppppppp');
  final oldPasswordController = TextEditingController(text: 'pppppppp');
  final phoneNumberController = TextEditingController(text: '2664512644');

  final passwordObscure = true.obs;
  final rePasswordObscure = true.obs;
  final oldPasswordObscure = true.obs;

  @override
  void onInit() {
    subscribeAuthChanges();

    super.onInit();
  }

  void subscribeAuthChanges() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      setUser();
    });
  }

  setUser() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      if (user.emailVerified) {
        uid.value = user.uid;
        isLogged.value = true;
        emailUsr.value = user.email != null ? user.email! : '';
        verifiedMail.value = true;
        displayName.value = user.displayName != null ? user.displayName! : '';
        photoURL.value = user.photoURL != null ? user.photoURL! : '';
        initials.value =
            user.displayName!.split(" ").map((l) => l[0]).take(2).join();
      } else {
        isLogged.value = false;
        uid.value = '';
        emailUsr.value = '';
        verifiedMail.value = false;
        displayName.value = '';
        photoURL.value = '';
        initials.value = '';
        Get.snackbar(
          "Email no verificado",
          "Verifique su casilla de mail o spam",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color.fromARGB(91, 142, 147, 254),
          duration: const Duration(seconds: 10),
        );
      }
    } else {
      isLogged.value = false;
      uid.value = '';
      emailUsr.value = '';
      verifiedMail.value = false;
      displayName.value = '';
      photoURL.value = '';
      initials.value = '';
    }
  }

  Future<void> signUp() async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          )
          .then(
            (res) => updateDisplayName().then(
              (res) => sendEmailVerification().then(
                (res) => signOut().then((res) {
                  Get.offAllNamed("/signin");
                }),
              ),
            ),
          );
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "Error on SignUp",
        e.message!,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color.fromARGB(91, 142, 147, 254),
        duration: const Duration(seconds: 5),
      );
      signOut();
    }
  }

  Future<void> signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "Error on SignIn",
        e.message!,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color.fromARGB(91, 142, 147, 254),
        duration: const Duration(seconds: 5),
      );
    }
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAllNamed("/signin");
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "Error on SignOut",
        e.message!,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color.fromARGB(91, 142, 147, 254),
        duration: const Duration(seconds: 5),
      );
    }
  }

  Future<void> sendEmailVerification() async {
    try {
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "Error sending email verification",
        e.message!,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color.fromARGB(91, 142, 147, 254),
        duration: const Duration(seconds: 5),
      );
    }
  }

  Future<void> updatePassword() async {
    try {
      await FirebaseAuth.instance.currentUser!
          .updatePassword(passwordController.text)
          .then((res) {
            Get.offAllNamed("/home");
            Get.snackbar(
              "Password Updated",
              "Su password fue actualizada",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: const Color.fromARGB(91, 142, 147, 254),
              duration: const Duration(seconds: 5),
            );
          });
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "Error updating password",
        e.message!,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color.fromARGB(91, 142, 147, 254),
        duration: const Duration(seconds: 5),
      );
    }
  }

  Future<void> resetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text)
          .then((onValue) {
            Get.offAllNamed("/signin");
            Get.snackbar(
              "Se emvió mail para recuperar su cuenta",
              "Verifique su casilla o spam",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: const Color.fromARGB(91, 142, 147, 254),
              duration: const Duration(seconds: 5),
            );
          });
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "Error reseting password",
        e.message!,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color.fromARGB(91, 142, 147, 254),
        duration: const Duration(seconds: 5),
      );
    }
  }

  Future<void> updateDisplayName() async {
    try {
      await FirebaseAuth.instance.currentUser!
          .updateDisplayName(nameController.text)
          .then((onValue) {
            Get.snackbar(
              "Display Name Updated",
              "Su nombre de usuario fue cambiado",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: const Color.fromARGB(91, 142, 147, 254),
              duration: const Duration(seconds: 5),
            );
          });
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "Error updating display name",
        e.message!,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color.fromARGB(91, 142, 147, 254),
        duration: const Duration(seconds: 5),
      );
    }
  }

  Future<void> updatePhotoURL(String photoURL) async {
    try {
      await FirebaseAuth.instance.currentUser!.updatePhotoURL(photoURL);
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "Error updating photo URL",
        e.message!,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color.fromARGB(91, 142, 147, 254),
        duration: const Duration(seconds: 5),
      );
    }
  }

  Future<void> updatePhoneNumber(PhoneAuthCredential number) async {
    try {
      await FirebaseAuth.instance.currentUser!.updatePhoneNumber(number);
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "Error updating photo URL",
        e.message!,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color.fromARGB(91, 142, 147, 254),
        duration: const Duration(seconds: 5),
      );
    }
  }

  void initRouteIsLogged() {
    routeIsLogged();
    ever(isLogged, (callback) => routeIsLogged());
  }

  void routeIsLogged() {
    if (isLogged.value) {
      Get.offAllNamed("/home");
    } else {
      Get.offAllNamed("/signin");
    }
  }

  void setpassObscure() {
    passwordObscure.value = !passwordObscure.value;
  }

  void setrePassObscure() {
    rePasswordObscure.value = !rePasswordObscure.value;
  }

  void setOldPassObscure() {
    oldPasswordObscure.value = !oldPasswordObscure.value;
  }

  void pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    photoUint.value = await image.readAsBytes();
    photoName.value = image.name;
  }

  void uploadUsrImage() async {
    final storageRef = FirebaseStorage.instance.ref();
    final imageRef = storageRef.child(
      '${uid.value}.${photoName.split('.').last}',
    );
    await imageRef.putData(photoUint.value);
    photoURL.value = await imageRef.getDownloadURL();
    await updatePhotoURL(photoURL.value);
    Get.offAllNamed("/home");
  }

  Future<UserCredential> signInWithGoogle() async {
    if (kIsWeb) {
      GoogleAuthProvider googleProvider = GoogleAuthProvider();

      googleProvider.addScope(
        'https://www.googleapis.com/auth/contacts.readonly',
      );
      googleProvider.setCustomParameters({'login_hint': 'user@example.com'});

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithPopup(googleProvider);
    } else {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    }
  }
}
