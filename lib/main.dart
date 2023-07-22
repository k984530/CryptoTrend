import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/screen/HomeScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: Colors.orange,
        ),
        useMaterial3: true,
      ),
      home: HomeScreen(),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => HomeScreen()),
      ],
    );
  }
}
