import 'package:flutter/material.dart';

class Palate {
  Palate(BuildContext context) {
    this.context = context;
    this.surfaceContainer = Color.fromARGB(
        Theme.of(context).colorScheme.surface.alpha,
        Theme.of(context).colorScheme.surface.red * 2,
        Theme.of(context).colorScheme.surface.green * 2,
        Theme.of(context).colorScheme.surface.blue * 2);
  }
  late BuildContext context;
  late Color surfaceContainer;
}
