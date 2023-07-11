import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testproject/core/constants/data_store_constants.dart';
import '../../main.dart';
import '../data/local_data_store.dart';

class ThemeService {
  LocalDataStore localDataStore = Get.find<LocalDataStore>();
  final themeBrightness = 'savedTheme';
  final themeColor = 'themeColor';

  Future<ThemeMode> getThemeMode() async{
    String theme = await getSavedTheme();
    print('Loading theme: $theme');

    switch (theme) {
      case 'dark':
        return ThemeMode.dark;
      case 'light':
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }

  Future<String> getSavedTheme() async{
    var value = await localDataStore.getString(DataStoreConstant.theme);
    print('Loaded: $value');
    return value ?? 'light';
  }

  Future<void> toggleTheme() async{
    String theme = await getSavedTheme();
    print('Loading theme: $theme');

    switch (theme) {
      case 'dark':
        localDataStore.setString(DataStoreConstant.theme, 'light');
        break;
      case 'light':
        localDataStore.setString(DataStoreConstant.theme, 'dark');
        break;
      default:
        localDataStore.setString(DataStoreConstant.theme, 'system');
        break;
    }
    // Reload the app
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      runApp(App(themeMode: await getThemeMode(),));
    });
  }
}