import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testproject/core/data/pet_details_model.dart';
import 'package:testproject/core/data/read_data.dart';

class HistoryPageController extends GetxController{

  RxList<PetDetailsModel> adoptedPetDetails = <PetDetailsModel>[].obs;

  @override
  void onReady() {
    getPetAdoptedList();
    super.onReady();
  }

  Future<void> getPetAdoptedList() async{
    adoptedPetDetails.value = await ReadData().fromLocal();
  }

}