import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SimpleController extends GetxController {
  int counter = 0;
  final String baseURL = 'https://fapi.binance.com/';
  final String time = "fapi/v1/time";
  final request = Uri.parse('https://fapi.binance.com/fapi/v1/time');
  final response = ''.obs;
  void increase() {
    counter++;
    update();
  }

  Future<void> test() async {
    await http.get(request).then((value) {
      response.value = value.body;
    });
    update();
  }
}
