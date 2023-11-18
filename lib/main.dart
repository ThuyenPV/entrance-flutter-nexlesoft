import 'package:entrance_flutter/app/common/services/category_service.dart';
import 'package:entrance_flutter/app/modules/category/bindings/category_binding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() async {
  runApp(
    ScreenUtilInit(
      designSize: const Size(360, 640),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          locale: const Locale('en', 'en'),
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          initialBinding: CategoryBinding(),
        );
      },
    ),
  );
}
