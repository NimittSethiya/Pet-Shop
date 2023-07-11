import 'package:flutter/material.dart';
import 'package:testproject/core/data/pet_details_model.dart';

class PetWithBackground extends StatelessWidget {
  final PetDetailsModel petDetail;
  final Color randomColor;
  const PetWithBackground({
    super.key, required this.petDetail, required this.randomColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      clipBehavior: Clip.hardEdge,
      alignment: Alignment.center,
      decoration: BoxDecoration(
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
              ),
              height: 150,),
          ),
          Align(
            alignment: Alignment.bottomLeft,
              child: Image.network(petDetail.image,)),
        ],
      ),
    );
  }
}