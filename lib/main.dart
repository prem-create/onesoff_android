import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/controllers/app_session_controller.dart';
import 'app/routes/appPages.dart';
import 'app/routes/appRoutes.dart';
import 'app/utils/deviceConstants/appColors.dart';
import 'app/utils/deviceConstants/appStrings.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(AppSessionController(), permanent: true);
  runApp(const OnesOffApp());
}

class OnesOffApp extends StatelessWidget {
  const OnesOffApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      initialRoute: AppRoutes.splash,
      getPages: AppPages.pages,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.surface,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.light,
        ),
      ),
    );
  }
}
