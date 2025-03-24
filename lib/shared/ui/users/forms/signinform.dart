import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:qubit_geo/shared/controllers/user_controller.dart';
import 'package:qubit_geo/shared/controllers/validators.dart';
import 'package:qubit_geo/shared/ui/logo/enterprise_logo.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({super.key});

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.put(UserController());
    final formKey = GlobalKey<FormState>();

    void sendSignIn() {
      if (formKey.currentState!.validate()) {
        userController.signIn();
      } else {
        Get.snackbar(
          "Error de Formulario",
          "Formulario inválido",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color.fromARGB(91, 142, 147, 254),
          duration: const Duration(seconds: 5),
        );
      }
    }

    return Obx(
      () => Container(
        constraints: BoxConstraints(minWidth: 360, maxWidth: 500),
        child: Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                EnterpriseLogo(),
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 30),
                  child: Text(
                    "Bienvenido",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                ),
                SizedBox(
                  width: 400,
                  child: TextFormField(
                    autofocus: true,
                    controller: userController.emailController,
                    validator: (value) {
                      if (!Validators().validateMail(value)) {
                        return "Email no válido";
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(labelText: "Email"),
                  ),
                ),
                SizedBox(
                  width: 400,
                  height: 60,
                  child: TextFormField(
                    controller: userController.passwordController,
                    validator: (value) {
                      if (!Validators().validateNumandLetters(value)) {
                        return "Password no válido";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: "Password",
                      suffix: IconButton(
                        onPressed: () => userController.setpassObscure(),
                        icon: Icon(Icons.lock, size: 20),
                      ),
                    ),
                    obscureText: userController.passwordObscure.value,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: FilledButton.icon(
                    onPressed: () {
                      sendSignIn();
                    },
                    icon: const Icon(Icons.login),
                    label: const Text("Ingresar"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Padding(
                    padding: EdgeInsets.only(left: 6, right: 6),
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Get.toNamed("pwdreset");
                      },
                      icon: const Icon(Icons.password),
                      label: const Text("Olvidó su Password?"),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Text("No tiene cuenta? Registrése con..."),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 4, right: 4),
                        child: IconButton(
                          onPressed: () {
                            Get.toNamed("/signup");
                          },
                          icon: const Icon(
                            Icons.mail,
                            color: Colors.blue,
                            size: 48,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 4, right: 4),
                        child: IconButton(
                          onPressed: () {},
                          icon: FaIcon(
                            FontAwesomeIcons.facebook,
                            size: 40,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 4, right: 4),
                        child: IconButton(
                          onPressed: () {},
                          icon: FaIcon(
                            FontAwesomeIcons.microsoft,
                            size: 40,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 4, right: 4),
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.apple,
                            color: Colors.blue,
                            size: 48,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 4, right: 4),
                        child: IconButton(
                          onPressed: () {
                            userController.signInWithGoogle();
                          },
                          icon: FaIcon(
                            FontAwesomeIcons.google,
                            size: 40,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
