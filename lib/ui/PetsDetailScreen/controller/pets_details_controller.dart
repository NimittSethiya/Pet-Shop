import 'package:get/get.dart';
import 'package:testproject/core/data/local_data_store.dart';
import 'package:testproject/core/data/pet_details_model.dart';
import 'package:testproject/core/data/read_data.dart';
import 'package:testproject/core/data/store_data.dart';

class PetsDetailsController extends GetxController{

  LocalDataStore localDataStore = Get.find<LocalDataStore>();

  @override
  void onReady() {
    super.onReady();
  }

  Future<bool> markAsAdopted({required PetDetailsModel pet}) async{
    List<PetDetailsModel> adoptedPets= await ReadData().fromLocal();
    pet.isAdopted = true;
    pet.adoptedAt = DateTime.now();
    adoptedPets.remove(adoptedPets.indexWhere((element) => element.id == pet.id));
    adoptedPets.add(pet);
    return await StoreData().execute(value: adoptedPets);
  }
}