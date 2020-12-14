import 'dart:async';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:gherkin/gherkin.dart';


import 'package:gherkin/gherkin.dart';

class WhenInsertSessionCode extends When1WithWorld<String, FlutterWorld> {
  @override
  Future<void> executeStep(String code) async {
    final finder = find.byValueKey(code);
    await FlutterDriverUtils.isPresent(world.driver, finder);
  }

  @override
  RegExp get pattern => RegExp(
      r"When I insert the code {string}");
}