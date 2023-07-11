import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/search_bar/gf_search_bar.dart';
import 'dart:math' as math;
import 'package:testproject/core/constants/color_constant.dart';
import 'package:testproject/core/constants/data_store_constants.dart';
import 'package:testproject/core/constants/string_constant.dart';
import 'package:testproject/core/constants/text_styles.dart';
import 'package:testproject/core/data/local_data_store.dart';
import 'package:testproject/core/data/pet_details_model.dart';
import 'package:testproject/core/extensions/color_extension.dart';
import 'package:testproject/core/extensions/theme_extension.dart';
import 'package:testproject/core/utils/hero_animation_util.dart';
import 'package:testproject/core/utils/size_utils.dart';
import 'package:testproject/core/utils/theme_service.dart';
import 'package:testproject/ui/MyPetsScreen/controller/my_pets_controller.dart';
import 'package:testproject/ui/PetsDetailScreen/pets_details_screen.dart';

import '../widgets/pet_detail_card.dart';

class MyPetsScreen extends GetWidget<MyPetsController> {
  const MyPetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppString.appName,
          style: AppTextStyle.pageTitle,
        ),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () async{
            await ThemeService().toggleTheme();
          }, icon: Icon(Icons.light_mode,))
        ],
      ),
      body: SafeArea(
        child: Obx(() {
          return Padding(
            padding: getPadding(bottom: 8),
            child: CustomScrollView(
              controller: controller.scrollController,
              slivers: [
                SliverToBoxAdapter(
                  child: GFSearchBar(
                    key: const Key('search'),
                    textColor: context.getSecondaryColor(),
                    searchList: controller.petDetails,
                    searchBoxInputDecoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      hintText: "Search by Name or Breed",
                      prefixIcon: const Icon(Icons.pets),
                      contentPadding: getPadding(all: 0),
                    ),
                    noItemsFoundWidget: Container(
                        padding: getPadding(all: 8),
                        child: const Text("No data found!")),
                    overlaySearchListItemBuilder: (PetDetailsModel? item) {
                      return item != null
                          ? Padding(
                            padding: getPadding(all: 8),
                            child: Row(
                              children: [
                                Container(
                                  clipBehavior: Clip.hardEdge,
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: context.getSecondaryColor(),
                                      borderRadius: BorderRadius.circular(60)
                                    ),
                                    child: Image.network(item.image, fit: BoxFit.contain,)),
                                Padding(
                                  padding: getPadding(all: 4),
                                  child: Text(item.name, style: AppTextStyle.description.copyWith(
                                    color: AppColors.primaryColor
                                  ),),
                                ),
                              ],
                            ),
                          )
                          : const Text("Not found");
                    },
                    searchQueryBuilder:
                        (String query, List<PetDetailsModel?> list) {
                      return list
                          .where((element) => (element!.name.contains(query) || element!.breed.contains(query)))
                          .toList();
                    },
                    onItemSelected: (PetDetailsModel? petdetail) {
                      final Color randomColor =
                          Color((math.Random().nextDouble() * 0xFF0000).toInt())
                              .withOpacity(0.6);
                      if (petdetail != null) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => PetsDetailsScreen(
                                  petDetailsModel: petdetail.obs,
                                  randomColor: randomColor,
                                ))).then((value) => controller.getPetListUpTo10());
                      }
                    },
                  ),
                ),
                SliverVisibility(
                  visible: controller.isSorting.value || controller.filterApplied.value,
                  sliver: SliverToBoxAdapter(
                    child: Padding(
                      padding: getPadding(right: 16, left: 16,),
                      child: GestureDetector(
                        onTap: (){
                          controller.filterApplied.value = false;
                          controller.isSorting.value = false;
                          controller.getPetList();
                        },
                        child: Container(
                          height: 40,
                          padding: getPadding(right: 16),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const [
                              Icon(Icons.close,size: 20,),
                              Center(child: Text("Clear all")),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: getPadding(right: 16, left: 16,),
                  sliver: SliverGrid(
                    key: Key('grid'),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final Color randomColor = RandomColor.getRandomColor();
                        return WidgetHeroAnimation(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => PetsDetailsScreen(
                                      petDetailsModel:
                                          controller.petDetails[index].obs,
                                      randomColor: randomColor,
                                    ))).then((value) => controller.getPetListUpTo10());
                          },
                          tag: controller.petDetails[index].name,
                          child: PetDetailCard(
                            key: Key("Item $index"),
                            petDetail: controller.petDetails[index],
                            randomColor: randomColor,
                          ),
                        );
                      },
                      childCount: controller.petDetails.length,
                    ),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: 0.7,
                      mainAxisExtent: 250
                    ),
                  ),
                )
              ],
            ),
          );
        }),
      ),
      floatingActionButton: Container(
        alignment: Alignment.bottomCenter,
        width: getHorizontalSize(150),
        height: 50,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            color: context.getSecondaryColor(),
            borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
                onPressed: () {
                  controller.getSortedList();
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.sort,
                      color: context.getBackgroundColor(),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Text(
                      "Sort",
                      style: AppTextStyle.buttonBlack.copyWith(
                        color: context.getBackgroundColor()
                      ),
                    ),
                  ],
                )),
            Container(
              width: 1,
              color: context.getBackgroundColor(),
            ),
            TextButton(
                onPressed: () {
                  controller.getFilteredList(category: Category.CAT);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.filter_alt_rounded,
                      color: context.getBackgroundColor(),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Text(
                      "Filter",
                      style: AppTextStyle.buttonBlack.copyWith(
                          color: context.getBackgroundColor()
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
