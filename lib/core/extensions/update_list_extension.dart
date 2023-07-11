import 'package:get/get.dart';
import 'package:testproject/core/data/pet_details_model.dart';

extension UpdateList<T> on List<T>{
  List<T> updateData(List<PetDetailsModel> data){
    for (int i = 0; i < length; i++) {
      PetDetailsModel currentObject = this[i] as PetDetailsModel;
      PetDetailsModel? newObject = data.firstWhereOrNull((obj) => obj.id == currentObject.id);
      if (newObject != null) {
        print(newObject.isAdopted);
        this[i] = newObject as T;
      }
    }
    return this;
  }
}