import 'package:get/get.dart';

import '../../../common/services/category_service.dart';
import '../controllers/category_controller.dart';

class CategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoryController>(
      () => CategoryController(),
    );
    Get.lazyPut<CategoryService>(() => CategoryService());
  }
}
