import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qubit_geo/shared/ui/logo/enterprise_logo.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          EnterpriseLogo(),
          Accordion(
            headerBackgroundColor: ColorScheme.of(context).secondary,
            paddingBetweenClosedSections: 0,
            paddingBetweenOpenSections: 0,
            paddingListTop: 0,
            paddingListHorizontal: 0,
            headerBorderRadius: 0,
            children: [
              AccordionSection(
                header: ListTile(
                  leading: Icon(
                    Icons.map_rounded,
                    color: ColorScheme.of(context).onSecondary,
                  ),
                  title: Text(
                    "Mapa",
                    style: TextStyle(
                      color: ColorScheme.of(context).onSecondary,
                    ),
                  ),
                  onTap: () async {
                    await Get.toNamed("/map");
                  },
                ),
                content: SizedBox(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
