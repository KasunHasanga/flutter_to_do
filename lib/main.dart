import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/db/DBHelper.dart';
import 'package:to_do_app/services/theme_services.dart';
import 'package:to_do_app/ui/home_page.dart';
import 'package:to_do_app/ui/splashScreen.dart';
import 'package:to_do_app/ui/theme.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await DBHelper.initDb();
  // await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeServices().theme,
      home: SplashScreen(),
      // home: HomePage(),
    );
  }
}
