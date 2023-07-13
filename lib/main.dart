import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/screen/FirstScreen.dart';
import 'package:test/screen/HomeScreen.dart';

import 'controller/SimpleController.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put(SimpleController());
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),
      home: HomeScreen(),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => HomeScreen()),
        GetPage(name: '/first', page: () => FirstScreen()),
      ],
    );
  }
}
