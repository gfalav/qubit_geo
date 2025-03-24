import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qubit_geo/shared/controllers/user_controller.dart';
import 'package:qubit_geo/shared/ui/logo/enterprise_logo.dart';

class ChangePhotoForm extends StatelessWidget {
  const ChangePhotoForm({super.key});

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.put(UserController());

    return Obx(
      () => Column(
        children: [
          EnterpriseLogo(),
          Padding(
            padding: EdgeInsets.only(top: 10, bottom: 30),
            child: Text(
              "Actualizar Foto de Perfil",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text("Imagen Actual"),
                  ),
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: ColorScheme.of(context).secondary,
                    backgroundImage:
                        userController.photoURL.value != ''
                            ? Image.network(userController.photoURL.value).image
                            : null,
                  ),
                ],
              ),
              SizedBox(width: 40),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text("Seleccione Nueva"),
                  ),
                  InkWell(
                    onTap: () {
                      userController.pickImage();
                    },
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: ColorScheme.of(context).tertiary,
                      backgroundImage:
                          userController.photoName.value != ''
                              ? Image.memory(
                                userController.photoUint.value,
                              ).image
                              : null,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 40),
            child: FilledButton.icon(
              onPressed: () {
                userController.uploadUsrImage();
              },
              label: Text("Actualiza"),
              icon: Icon(Icons.update),
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
    );
  }
}
