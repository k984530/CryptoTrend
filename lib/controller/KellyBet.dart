import 'package:get/get.dart';

class KellyBet extends GetxController {
  RxDouble winRate = 0.0.obs;
  RxDouble lossRate = 0.0.obs;
  RxDouble profit = 0.0.obs;
  RxDouble loss = 0.0.obs;
  RxDouble result = 0.0.obs;

  calculate() {
    if (loss.value != 0.0 || profit.value != 0.0)
      result.value = winRate.value / loss.value - lossRate.value / profit.value;
  }
}
