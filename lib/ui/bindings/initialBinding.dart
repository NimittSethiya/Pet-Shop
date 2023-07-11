import 'package:get/get.dart';
import 'package:testproject/ui/HistoryPage/controller/history_page_controller.dart';
import 'package:testproject/ui/MyPetsScreen/controller/my_pets_controller.dart';

import '../../../core/data/local_data_store.dart';
import '../../../core/data/local_data_store_impl.dart';
import '../../core/data/store_data.dart';
import '../PetsDetailScreen/controller/pets_details_controller.dart';


class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyPetsController());
    Get.lazyPut(() => PetsDetailsController());
    Get.lazyPut(() => HistoryPageController());
    Get.lazyPut<LocalDataStore>(() => LocalDataStoreImpl());
    Get.lazyPut(() => StoreData());
  }
}
