import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../controller/SimpleController.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed('/first');
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    height: 150,
                    width: size.width * 0.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).colorScheme.shadow,
                          offset: Offset(10, 10),
                          blurRadius: 10,
                        ),
                      ],
                      color: Theme.of(context).colorScheme.primaryContainer,
                    ),
                    child: Text(
                      "보유 금액",
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => GestureDetector(
                    onTap: () async {
                      await Get.find<SimpleController>().test();
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 40),
                      height: 300,
                      width: size.width * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).colorScheme.shadow,
                            offset: Offset(10, 10),
                            blurRadius: 10,
                          ),
                        ],
                        color: Theme.of(context).colorScheme.primaryContainer,
                      ),
                      child: Text(
                        Get.find<SimpleController>().response.value,
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 40),
                  height: 300,
                  width: size.width * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).colorScheme.shadow,
                        offset: Offset(10, 10),
                        blurRadius: 10,
                      ),
                    ],
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  child: Text(
                    "과거 내역",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
