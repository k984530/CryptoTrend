import 'package:get/get.dart';

class SimpleController extends GetxController {
  int counter = 0;

  void increase() {
    counter++;
    update();
  }
}
