import 'dart:convert';

import 'package:entrance_flutter/app/models/category.dart';
import 'package:entrance_flutter/app/modules/category/controllers/category_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../common/storage/local_storage.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
        // leading: const SizedBox.shrink(),
      ),
      body: Center(
        child: FutureBuilder(
          future: LocalStorage.onGetList(
            key: SharedKey.categorySelected,
          ),
          builder: (context, snapshots) {
            final categorySelected = snapshots.data ?? [];
            if (categorySelected.isEmpty) {
              return const Center(child: Text('No category selected'));
            }
            return ListView.separated(
              shrinkWrap: true,
              itemCount: categorySelected.length,
              itemBuilder: (context, index) {
                final category = categorySelected[index];
                return Center(
                  child: Text(
                    category.toLowerCase(),
                  ),
                );
              },
              separatorBuilder: (_, __) => const SizedBox(height: 16),
            );
          },
        ),
      ),
    );
  }
}
