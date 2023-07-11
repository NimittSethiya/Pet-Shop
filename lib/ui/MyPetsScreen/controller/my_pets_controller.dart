import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testproject/core/data/pet_details_model.dart';
import 'package:testproject/core/data/read_data.dart';

class MyPetsController extends GetxController{

  RxList<PetDetailsModel> petDetails = <PetDetailsModel>[].obs;
  RxBool isSorting = false.obs;
  RxBool filterApplied = false.obs;
  final ScrollController scrollController = ScrollController();

  @override
  void onReady() {
    scrollController.addListener(_scrollListener);
    getPetListUpTo10();
    super.onReady();
  }

  Future<void> getPetList() async{
    petDetails.value = await ReadData().fromJson();
  }

  Future<void> getPetListUpTo10() async{
    petDetails.value = await ReadData().fromJson();
    petDetails.value = petDetails.sublist(0, 10);
  }

  Future<void> getFilteredList({required Category category}) async{
    filterApplied.value = true;
    petDetails.value = petDetails.where((element) => element.category == category).toList();
  }

  Future<void> getSortedList() async{
    isSorting.value = true;
    petDetails.sort((petA, petB) => petA.price.compareTo(petB.price));
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
      Future.delayed(const Duration(seconds: 1), () {
        getPetList();
      });
    }
  }
}