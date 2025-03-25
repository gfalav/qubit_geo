import 'package:flutter/material.dart';
import 'package:qubit_geo/shared/ui/scaffold/my_scaffold.dart';

class UnknownPage extends StatelessWidget {
  const UnknownPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      left: SizedBox(),
      main: Center(
        child: Text(
          "Error - Page not found",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      right: SizedBox(),
      bottom: SizedBox(),
    );
  }
}
