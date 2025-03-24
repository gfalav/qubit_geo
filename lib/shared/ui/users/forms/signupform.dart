import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qubit_geo/shared/controllers/user_controller.dart';
import 'package:qubit_geo/shared/controllers/validators.dart';
import 'package:qubit_geo/shared/ui/logo/enterprise_logo.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.put(UserController());
    final formKey = GlobalKey<FormState>();

    void sendSignUp() {
      if (formKey.currentState!.validate()) {
        userController.signUp();
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
              children: [
                EnterpriseLogo(),
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 30),
                  child: Text(
                    "Crear cuenta con Email",
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
                  child: TextFormField(
                    controller: userController.nameController,
                    validator: (value) {
                      if (!Validators().validateNumandLetters(value)) {
                        return "Nombre no válido";
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: "Nombre y Apellido",
                    ),
                  ),
                ),
                SizedBox(
                  width: 400,
                  child: TextFormField(
                    controller: userController.phoneNumberController,
                    validator: (value) {
                      if (!Validators().validateNumandLetters(value)) {
                        return "Nümero no válido";
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: "Teléfono Móvil",
                    ),
                  ),
                ),
                SizedBox(
                  width: 400,
                  height: 57,
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
                SizedBox(
                  width: 400,
                  height: 57,
                  child: TextFormField(
                    controller: userController.repasswordController,
                    validator: (value) {
                      if (userController.passwordController.text !=
                          userController.repasswordController.text) {
                        return "Passwords no coinciden";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: "Confirme Password",
                      suffix: IconButton(
                        onPressed: () => userController.setrePassObscure(),
                        icon: Icon(Icons.lock, size: 20),
                      ),
                    ),
                    obscureText: userController.rePasswordObscure.value,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: FilledButton.icon(
                    onPressed: () {
                      sendSignUp();
                    },
                    icon: const Icon(Icons.login),
                    label: const Text("Registrarse"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Padding(
                    padding: EdgeInsets.only(left: 6, right: 6),
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(Icons.arrow_back),
                      label: const Text("Volver a anterior"),
                    ),
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
