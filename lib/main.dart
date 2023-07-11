import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testproject/core/constants/color_constant.dart';
import 'package:testproject/core/data/store_data.dart';
import 'package:testproject/core/extensions/theme_extension.dart';
import 'package:testproject/core/utils/theme_service.dart';
import 'package:testproject/ui/bindings/initialBinding.dart';
import 'package:testproject/ui/home.dart';

import 'core/data/local_data_store.dart';
import 'core/data/local_data_store_impl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.lazyPut<LocalDataStore>(() => LocalDataStoreImpl());
  ThemeMode themeMode = await ThemeService().getThemeMode();
  runApp(App(themeMode: themeMode));
}

class App extends StatelessWidget {
  final ThemeMode themeMode;

  const App({super.key, required this.themeMode});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Pet Shop',
      theme: context.getTheme(
          color: AppColors.primaryColor,
          secondaryColor: AppColors.secondaryColor,
          brightness: Brightness.light,
          primarySwatch: AppColors.black),
      darkTheme: context.getTheme(
          color: AppColors.secondaryColor,
          secondaryColor: AppColors.primaryColor,
          brightness: Brightness.dark,
          primarySwatch: AppColors.white),
      themeMode: themeMode,
      initialBinding: InitialBinding(),
      home: const HomePage(),
    );
  }
}
