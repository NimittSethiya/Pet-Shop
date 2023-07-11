import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:testproject/core/constants/data_store_constants.dart';
import 'package:testproject/core/data/pet_details_model.dart';
import 'package:testproject/core/extensions/update_list_extension.dart';
import 'local_data_store.dart';

class ReadData{
  LocalDataStore localDataStore = Get.find<LocalDataStore>();

  Future<List<PetDetailsModel>> fromJson() async{
    String data = await rootBundle.loadString('asset/data.json');
    List<PetDetailsModel> pets = petDetailsModelFromJson(data);
    List<PetDetailsModel> adoptedPets = await fromLocal();
    return pets.updateData(adoptedPets);
  }

  Future<List<PetDetailsModel>> fromLocal() async {
    String? adoptedPetsData = await localDataStore.getString(DataStoreConstant.adoptedPets);
    return adoptedPetsData != null ? petDetailsModelFromJson(adoptedPetsData) : <PetDetailsModel>[];
  }
}