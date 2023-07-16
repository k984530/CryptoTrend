import 'package:get/get.dart';
import 'dart:math';

class KellyBet extends GetxController {
  RxDouble winRate = 0.0.obs;
  RxDouble lossRate = 0.0.obs;
  RxDouble profit = 0.0.obs;
  RxDouble loss = 0.0.obs;
  RxDouble result = 0.0.obs;
  RxDouble expectResult = 0.0.obs;

  calculate() {
    if (winRate.value / loss.value - lossRate.value / profit.value < 0) {
      result.value = 0;
      expectResult.value = 0;
    } else if (winRate.value / loss.value - lossRate.value / profit.value >=
        1) {
      result.value = 1;
      expectResult.value = 100;
    } else {
      result.value = winRate.value / loss.value - lossRate.value / profit.value;
      expectResult.value = pow(
                  ((1 - result.value) + (result.value * (1 + profit.value))),
                  100 * winRate.value)
              .toDouble() *
          pow(((1 - result.value) + (result.value * (1 - loss.value))),
                  100 * lossRate.value)
              .toDouble();
      if (expectResult.value > 100) {
        expectResult.value = 100;
      }
    }
  }
}
