import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qubit_geo/shared/controllers/user_controller.dart';
import 'package:qubit_geo/shared/controllers/validators.dart';
import 'package:qubit_geo/shared/ui/logo/enterprise_logo.dart';

class Changeusrnameform extends StatelessWidget {
  const Changeusrnameform({super.key});

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.put(UserController());
    final formKey = GlobalKey<FormState>();

    void sendUpdateUsrName() {
      if (formKey.currentState!.validate()) {
        userController.updateDisplayName();
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
                  "Actualizar Nombre de Usuario",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
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
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: FilledButton.icon(
                  onPressed: () {
                    sendUpdateUsrName();
                  },
                  icon: const Icon(Icons.login),
                  label: const Text("Actualiza Nombre"),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30),
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
