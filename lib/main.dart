import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:qubit_geo/shared/controllers/user_controller.dart';
import 'package:qubit_geo/shared/ui/home/home.dart';
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
  await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  await FirebaseStorage.instance.useStorageEmulator('localhost', 9199);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.put(UserController());
    final brightness = View.of(context).platformDispatcher.platformBrightness;

    TextTheme textTheme = createTextTheme(
      context,
      "Red Hat Display",
      "Open Sans Condensed",
    );

    MaterialTheme theme = MaterialTheme(textTheme);
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      onReady: () => userController.initRouteIsLogged(),
      home: Home(),
      initialRoute: '/',
      getPages: [
        GetPage(name: "/home", page: () => Home()),
        GetPage(name: "/signin", page: () => SignIn()),
        GetPage(name: "/signup", page: () => SignUp()),
        GetPage(name: "/pwdreset", page: () => ResetPassword()),
        GetPage(name: "/changepwd", page: () => ChangePassword()),
        GetPage(name: "/updateuser", page: () => ChangeUsrName()),
        GetPage(name: "/changephoto", page: () => ChangePhotoUsr()),
      ],
    );
  }
}
