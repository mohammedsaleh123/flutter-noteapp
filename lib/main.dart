import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noteapp/consts/color_const.dart';
import 'package:noteapp/view/home_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: primaryColor,
        appBarTheme: AppBarTheme(backgroundColor: primaryColor),
        useMaterial3: true,
      ),
      home: HomeView(),
    );
  }
}
