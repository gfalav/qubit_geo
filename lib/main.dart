import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:qubit_geo/shared/ui/home/home.dart';
import 'firebase_options.dart';
import 'package:qubit_geo/shared/ui/theme/theme.dart';
import 'package:qubit_geo/shared/ui/theme/util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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
      home: Home(),
    );
  }
}
