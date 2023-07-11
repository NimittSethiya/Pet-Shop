import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testproject/core/extensions/color_extension.dart';
import 'package:testproject/ui/HistoryPage/controller/history_page_controller.dart';
import 'package:testproject/ui/widgets/pet_detail_listtile.dart';

import '../../core/constants/string_constant.dart';
import '../../core/constants/text_styles.dart';

class HistoryPage extends GetWidget<HistoryPageController> {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppString.history,
          style: AppTextStyle.pageTitle,
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        return ListView.builder(
            itemCount: controller.adoptedPetDetails.length,
            itemBuilder: (context, index) {
              return PetDetailListTile(
                  petDetail: controller.adoptedPetDetails[index],
                  randomColor: RandomColor.getRandomColor());
            });
      }),
    );
  }

}