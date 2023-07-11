import 'package:flutter/material.dart';
import 'package:testproject/core/constants/color_constant.dart';
import 'package:testproject/core/constants/text_styles.dart';
import 'package:testproject/core/data/pet_details_model.dart';
import 'package:testproject/core/extensions/theme_extension.dart';
import 'package:testproject/core/utils/size_utils.dart';

class PetDetailCard extends StatelessWidget {
  final PetDetailsModel petDetail;
  final Color randomColor;
  const PetDetailCard({
    super.key, required this.petDetail, required this.randomColor,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 350,
      clipBehavior: Clip.hardEdge,
      alignment: Alignment.center,
     margin: getMargin(all: 2),
     decoration: BoxDecoration(
       borderRadius: BorderRadius.circular(20),
       boxShadow: [
         BoxShadow(color: randomColor)
       ],
       border: Border.all(color: randomColor, strokeAlign: BorderSide.strokeAlignOutside)
     ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                color: randomColor,
                  borderRadius: BorderRadius.circular(20)
              ),
              height: 150,),
          ),
          Image.network(petDetail.image, height: 280,),
          Align(
            alignment: Alignment.topRight,
            child: Container(
                padding: getPadding(all: 12),
                decoration: BoxDecoration(
                    color: randomColor,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20)),
                  border: Border.all(color: randomColor)
                ),
                child: Text("₹${(petDetail.price * 100).toString()}", style: AppTextStyle.title.copyWith(
                  color: Color(randomColor.value).computeLuminance() > 0.5 ? AppColors.primaryColor : AppColors.secondaryColor,
                ),)),
          ),
          if(petDetail.isAdopted!)
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                height: 200,
                width: double.infinity,
                  padding: getPadding(top: 4,bottom: 4),
                  color: context.getSecondaryColor().withOpacity(0.5),
                  child: Center(
                    child: Container(
                      height: 20,
                      width: double.infinity,
                      color: randomColor,
                      child: Center(
                        child: Text("Already Adopted", style: AppTextStyle.title.copyWith(
                          color: context.getBackgroundColor()
                        ),),
                      ),
                    ),
                  ),),
            ),
          Container(
              height:60,
              padding: getPadding(left: 12,top: 4,bottom: 4),
              width: double.infinity,
              color: context.getBackgroundColor(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(petDetail.name.toUpperCase(), style: AppTextStyle.title,),
                  Text(petDetail.description, style: AppTextStyle.description,),
                ],
              )),
        ],
      ),
    );
  }
}