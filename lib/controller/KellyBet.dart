import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';

class KellyBet extends GetxController {
  RxDouble winRate = 0.0.obs;
  RxDouble lossRate = 0.0.obs;
  RxDouble profit = 0.0.obs;
  RxDouble loss = 0.0.obs;
  RxDouble result = 0.0.obs;
  RxDouble expectResult = 0.0.obs;
  TextEditingController winRateCtr = TextEditingController();
  TextEditingController profitCtr = TextEditingController();
  TextEditingController lossCtr = TextEditingController();

  @override
  onInit() {
    super.onInit();
    SharedPreferences.getInstance().then(
      (value) {
        winRate.value = value.getDouble('winRate') ?? 0.0;
        lossRate.value = value.getDouble('lossRate') ?? 0.0;
        profit.value = value.getDouble('profit') ?? 0.0;
        loss.value = value.getDouble('loss') ?? 0.0;

        winRateCtr.text = (winRate.value * 100).toString();
        profitCtr.text = (profit.value * 100).toString();
        lossCtr.text = (loss.value * 100).toString();
        calculate();
      },
    );
  }

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
    SharedPreferences.getInstance().then(
      (value) {
        value.setDouble('winRate', winRate.value);
        value.setDouble('lossRate', lossRate.value);
        value.setDouble('profit', profit.value);
        value.setDouble('loss', loss.value);
      },
    );
  }
}
