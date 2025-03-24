import 'package:flutter/material.dart';

class EnterpriseLogo extends StatelessWidget {
  const EnterpriseLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 270,
      child: Image.asset(
        'lib/shared/assets/images/Qubit-POS-sf.png',
        width: 270,
      ),
    );
  }
}
