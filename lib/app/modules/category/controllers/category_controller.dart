import 'package:entrance_flutter/app/models/category.dart';
import 'package:get/get.dart';

import '../../../common/services/category_service.dart';

class CategoryController extends GetxController {
  final CategoryService networkController = Get.find<CategoryService>();
  late RxList<Category> categorySelected;
  @override
  void onInit() {
    categorySelected = RxList([]);
    super.onInit();
  }

  void onSelectCategory({required Category category}) {
    if (isContain(category: category)) {
      categorySelected.removeWhere((e) => e == category);
    } else {
      categorySelected.add(category);
    }
  }

  bool isContain({required Category category}) {
    return categorySelected.contains(category);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
