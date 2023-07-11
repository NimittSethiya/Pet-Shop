import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:testproject/core/constants/text_styles.dart';
import 'package:testproject/core/extensions/theme_extension.dart';

import '../../core/data/pet_details_model.dart';

class PetDetailListTile extends StatelessWidget {
  final PetDetailsModel petDetail;
  final Color randomColor;
  const PetDetailListTile({Key? key,
    required this.petDetail,
    required this.randomColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8,),
        Text(DateFormat("MMM dd, yyyy").format(petDetail.adoptedAt!), style: AppTextStyle.description,),
        const SizedBox(height: 8,),
        ListTile(
          tileColor: randomColor,
          leading: Container(
            decoration: BoxDecoration(
              color: randomColor,
              borderRadius: BorderRadius.circular(10),
                border: Border.all(color: context.getBackgroundColor())
            ),
              child: Image.network(petDetail.image)),
          title: Text(petDetail.name),
          subtitle: Text(petDetail.description),
        ),
      ],
    );
  }
}
