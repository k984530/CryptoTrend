import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:test/Data/Servertime.dart';

class SimpleController extends GetxController {
  int counter = 0;
  final String baseURL = 'https://fapi.binance.com/';
  final String time = "fapi/v1/time";
  final request = Uri.parse('https://fapi.binance.com/fapi/v1/time');
  Rx<ServerTime> response = ServerTime(serverTime: 1).obs;
  void increase() {
    counter++;
    update();
  }

  Future<void> test() async {
    await http.get(request).then((value) {
      print("1 : " + value.body);
      response.value = ServerTime.fromJson(value.body);
      print(response.value.serverTime);
    });
  }
}
