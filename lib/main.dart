import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:qubit_geo/app/ui/maps/map_view.dart';
import 'package:qubit_geo/shared/controllers/geolocator_controller.dart';
import 'package:qubit_geo/shared/controllers/user_controller.dart';
import 'package:qubit_geo/shared/ui/home/home.dart';
import 'package:qubit_geo/shared/ui/unknown_page/unknown_page.dart';
import 'package:qubit_geo/shared/ui/users/change_password.dart';
import 'package:qubit_geo/shared/ui/users/change_photo_usr.dart';
import 'package:qubit_geo/shared/ui/users/change_usr_name.dart';
import 'package:qubit_geo/shared/ui/users/reset_password.dart';
import 'package:qubit_geo/shared/ui/users/sign_in.dart';
import 'package:qubit_geo/shared/ui/users/sign_up.dart';
import 'firebase_options.dart';
import 'package:qubit_geo/shared/ui/theme/theme.dart';
import 'package:qubit_geo/shared/ui/theme/util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAppCheck.instance.activate(
    webProvider: ReCaptchaV3Provider(
      '6LfKgxIrAAAAAOyCLhQb6Me7uJL-YQG_I1jmShya',
    ),
    androidProvider: AndroidProvider.playIntegrity,
    appleProvider: AppleProvider.appAttest,
  );
  //emuladores
  //await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  //await FirebaseStorage.instance.useStorageEmulator('localhost', 9199);
  //FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.put(UserController());
    final GeolocatorController geolocatorController = Get.put(
      GeolocatorController(),
    );
    geolocatorController.recordPositionEnabled.value = false;
    final brightness = View.of(context).platformDispatcher.platformBrightness;

    TextTheme textTheme = createTextTheme(
      context,
      "Red Hat Display",
      "Open Sans Condensed",
    );

    MaterialTheme theme = MaterialTheme(textTheme);
    return GetMaterialApp(
      title: 'Qubit Geo',
      debugShowCheckedModeBanner: false,
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      onReady: () => userController.initRouteIsLogged(),
      home: Home(),
      initialRoute: '/home',
      unknownRoute: GetPage(name: "/notfound", page: () => UnknownPage()),
      getPages: [
        GetPage(
          name: "/home",
          page: () => Home(),
          transition: Transition.leftToRightWithFade,
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: "/signin",
          page: () => SignIn(),
          transition: Transition.fadeIn,
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: "/signup",
          page: () => SignUp(),
          transition: Transition.fadeIn,
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: "/pwdreset",
          page: () => ResetPassword(),
          transition: Transition.fadeIn,
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: "/changepwd",
          page: () => ChangePassword(),
          transition: Transition.leftToRightWithFade,
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: "/updateuser",
          page: () => ChangeUsrName(),
          transition: Transition.leftToRightWithFade,
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: "/changephoto",
          page: () => ChangePhotoUsr(),
          transition: Transition.leftToRightWithFade,
          transitionDuration: const Duration(milliseconds: 500),
        ),

        GetPage(
          name: "/map",
          page: () => MapView(),
          transition: Transition.leftToRightWithFade,
          transitionDuration: const Duration(milliseconds: 500),
        ),
      ],
    );
  }
}
