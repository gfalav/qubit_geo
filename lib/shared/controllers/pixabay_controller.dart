import 'package:dio/dio.dart';
import 'package:get/get.dart';

class PixabayController extends GetxController {
  final RxList images = [].obs;

  @override
  void onInit() {
    getImages();
    super.onInit();
  }

  Future<void> getImages() async {
    final dio = Dio();
    await dio
        .get(
          'https://pixabay.com/api/?key=49226875-dd469dfea4c42634d1eec15d2&q=nature&orientation=vertical&min_width=1600&min_height=1200&image_type=photo&per_page=80',
        )
        .then((result) {
          result.data['hits'].forEach((element) {
            images.add(element['webformatURL']);
          });
        });
  }
}
