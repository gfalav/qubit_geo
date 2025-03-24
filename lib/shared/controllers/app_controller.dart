import 'package:get/get.dart';

class AppController extends GetxController {
  //devType
  final devType = ''.obs;

  // appBar Settings
  final appBarTitle = ''.obs;
  final appBarIcon = 0.obs;

  //visibility options
  final appBarVisible = true.obs;
  final appBarActionsVisible = true.obs;
  final drawerVisible = true.obs;
  final leftPanelVisible = true.obs;
  final rightPanelVisible = true.obs;
  final bottomPanelVisible = true.obs;

  //layer dimensions
  final totalWidth = 0.0.obs;
  final totalHeight = 0.0.obs;
  final leftPanelWidth = 0.0.obs;
  final rightPanelWidth = 0.0.obs;

  void setTotalDimensions(double width, double height) {
    totalWidth.value = width;
    totalHeight.value = height;
    if (width < 580) {
      devType.value = 'Mobile';
    } else if (width < 900) {
      devType.value = 'Tablet';
    } else {
      devType.value = 'Desktop';
    }
  }

  void setAppBarState(
    String appBarTitle,
    int appBarIcon,
    bool appBarVisible,
    bool appBarActionsVisible,
    bool drawerVisible,
    bool leftPanelVisible,
    bool rightPanelVisible,
    bool bottomPanelVisible,
    double leftPanelWidth,
    double rightPanelWidth,
  ) {
    this.appBarTitle.value = appBarTitle;
    this.appBarIcon.value = appBarIcon;
    this.appBarVisible.value = appBarVisible;
    this.appBarActionsVisible.value = appBarActionsVisible;
    this.drawerVisible.value = drawerVisible;
    this.leftPanelVisible.value = leftPanelVisible;
    this.rightPanelVisible.value = rightPanelVisible;
    this.bottomPanelVisible.value = bottomPanelVisible;
    this.leftPanelWidth.value = leftPanelWidth;
    this.rightPanelWidth.value = rightPanelWidth;
  }
}
