import 'package:get/get.dart';
import 'package:testproject/core/constants/data_store_constants.dart';
import 'package:testproject/core/data/local_data_store.dart';
import 'package:testproject/core/data/pet_details_model.dart';

class StoreData{
  LocalDataStore localDataStore = Get.find<LocalDataStore>();

  Future<bool> execute({required List<PetDetailsModel> value}) async{
    print(value.first.adoptedAt);
    return localDataStore.setString(DataStoreConstant.adoptedPets, petDetailsModelToJson(value));
  }
}