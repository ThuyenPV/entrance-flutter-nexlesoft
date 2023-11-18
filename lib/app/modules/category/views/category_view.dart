import 'dart:ui';

import 'package:entrance_flutter/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../common/services/category_service.dart';
import '../../../routes/app_pages.dart';
import '../controllers/category_controller.dart';

class CategoryView extends GetView<CategoryController> {
  CategoryView({Key? key}) : super(key: key);

  final categoryService = Get.find<CategoryService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            flex: 2,
            child: Stack(
              fit: StackFit.loose,
              children: [
                SizedBox(
                  height: 1.sh * 2 / 5,
                  width: 1.sw,
                  child: ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return const LinearGradient(
                        colors: [
                          Colors.black26,
                          Colors.black12,
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ).createShader(bounds);
                    },
                    blendMode: BlendMode.difference,
                    child: Assets.images.cover.image(
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Wellcome to Flutter Test',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Please select categories what you would like to see on your feed. You can set this later on Filter.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 48, horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.white,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (controller.categorySelected.isEmpty) {
                            Get.snackbar(
                              'Hint!',
                              'At least one category must be selected',
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                            );
                          } else {
                            categoryService
                                .onCompleteCategory(
                                    categories: controller.categorySelected)
                                .then((_) {
                              Get.toNamed(Routes.HOME);
                            });
                          }
                        },
                        child: const Text(
                          'Done',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            color: Colors.black87,
            height: 1.sh * 3 / 5,
            width: 1.sw,
            child: GridView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 3 / 2,
              ),
              itemCount: categoryService.categories.length,
              itemBuilder: (BuildContext context, int index) {
                final category = categoryService.categories[index];
                return Obx(
                  () => GestureDetector(
                    onTap: () {
                      controller.onSelectCategory(category: category);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: controller.isContain(category: category)
                            ? null
                            : Border.all(color: Colors.white10),
                        borderRadius: BorderRadius.circular(8),
                        gradient: controller.isContain(category: category)
                            ? const LinearGradient(
                                colors: [
                                  Color(0xFF8d0cf0),
                                  Color(0xFF8c2cb3),
                                ],
                                begin: FractionalOffset(0, 1),
                                end: FractionalOffset(0, 0),
                                stops: [0.0, 1.0],
                                tileMode: TileMode.clamp,
                              )
                            : null,
                      ),
                      child: Text(
                        categoryService.categories[index].name,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
