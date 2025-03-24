import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qubit_geo/shared/controllers/user_controller.dart';
import 'package:qubit_geo/shared/controllers/validators.dart';
import 'package:qubit_geo/shared/ui/logo/enterprise_logo.dart';

class ResetPwdForm extends StatelessWidget {
  const ResetPwdForm({super.key});

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.put(UserController());
    final formKey = GlobalKey<FormState>();

    void sendReset() {
      if (formKey.currentState!.validate()) {
        userController.resetPassword();
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

    return Container(
      constraints: BoxConstraints(minWidth: 360, maxWidth: 500),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              EnterpriseLogo(),
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 30),
                child: Text(
                  "Ingrese su email",
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
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: FilledButton.icon(
                  onPressed: () {
                    sendReset();
                  },
                  icon: const Icon(Icons.login),
                  label: const Text("Envía email"),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 80),
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
    );
  }
}
