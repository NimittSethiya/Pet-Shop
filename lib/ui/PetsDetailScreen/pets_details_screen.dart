import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:testproject/core/constants/string_constant.dart';
import 'package:testproject/core/constants/text_styles.dart';
import 'package:testproject/core/data/pet_details_model.dart';
import 'package:testproject/core/extensions/theme_extension.dart';
import 'package:testproject/core/utils/size_utils.dart';
import 'package:testproject/ui/PetsDetailScreen/controller/pets_details_controller.dart';
import 'package:testproject/ui/widgets/pet_with_background.dart';

import '../../core/constants/color_constant.dart';

class PetsDetailsScreen extends GetWidget<PetsDetailsController> {
  final Rx<PetDetailsModel> petDetailsModel;
  final Color randomColor;

  const PetsDetailsScreen(
      {super.key, required this.petDetailsModel, required this.randomColor});

  @override
  Widget build(BuildContext context) {
    Color pageThemeColor = Color(randomColor.value).computeLuminance() > 0.5
        ? AppColors.primaryColor
        : AppColors.secondaryColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(petDetailsModel.value.name,
          style: AppTextStyle.pageTitle.copyWith(color: pageThemeColor),),
        backgroundColor: randomColor,
        iconTheme: IconThemeData(color: pageThemeColor),
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          height: size.height,
          child: Stack(
            children: [
              PetWithBackground(
                petDetail: petDetailsModel.value, randomColor: randomColor,),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Container(
                  height: getVerticalSize(size.height * 0.5),
                  padding: getPadding(all: 16),
                  decoration: BoxDecoration(
                      color: context.getBackgroundColor(),
                      borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(20))
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(child: Text(
                        petDetailsModel.value.name, style: AppTextStyle.bigTitle
                          .copyWith(color: randomColor),)),
                      const SizedBox(height: 12,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.pets_rounded, color: randomColor,),
                              const SizedBox(width: 4,),
                              Text(petDetailsModel.value.breed,
                                style: AppTextStyle.description,)
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.calendar_month, color: randomColor,),
                              const SizedBox(width: 4,),
                              Text(
                                "${petDetailsModel.value.age.toString()} Years",
                                style: AppTextStyle.description,)
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 12,),
                      Text(petDetailsModel.value.longDescription,
                        style: AppTextStyle.longDescription,)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomSheet: Obx(() {
        return Container(
          height: 90,
          color: context.getBackgroundColor(),
          width: size.width,
          padding: getPadding(all: 16),
          child: GFButton(
            color: randomColor.withOpacity(1.0),
            disabledColor: Colors.grey,
            disabledTextColor: Colors.black,
            textStyle: AppTextStyle.title.copyWith(
                color: pageThemeColor
            ),
            onPressed: petDetailsModel.value.isAdopted! ? null : () {
              petDetailsModel.value.isAdopted = true;
              petDetailsModel.refresh();
              controller.markAsAdopted(pet: petDetailsModel.value);
            },
            text: petDetailsModel.value.isAdopted!
                ? "Already Adopted"
                : "Adopt Me",
          ),
        );
      }),
    );
  }
}