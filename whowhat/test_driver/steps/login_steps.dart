import 'dart:async';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:gherkin/gherkin.dart';

// Given I am in the "Log in" screen

class UserInScreen extends Given1WithWorld<String, FlutterWorld> {
  @override
  Future<void> executeStep(String input1) async {
    final locator = find.byValueKey(input1);
    var text = await world.driver.getText(locator, timeout: Duration(seconds: 2));
    expect(text, input1);
  }

  @override
  RegExp get pattern => RegExp(r"I am in the {string} screen");
}

// When I enter my credentials

/*class enterText extends When1WithWorld<String, FlutterWorld> {
  @override
  Future<void> executeStep(String input1) async {
      //processes input
  }

  @override
  RegExp get pattern => RegExp(r"I enter {string} as my credentials");
}*/

// And I tap the "log in" button

class UserTapsButton extends When1WithWorld<String, FlutterWorld> {
  @override
  Future<void> executeStep(String input1) async {
    final locator = find.byValueKey(input1);
    await world.driver.tap(locator);
  }

  @override
  RegExp get pattern => RegExp(r"I tap the {string} button");
}

// Then I expect to be logged in 
/*
class UserLoggedIn extends Then2WithWorld<String, String, FlutterWorld> {
  @override
  Future<void> executeStep(String input1, String input2) async {
    // processes input
  }

  @override
  RegExp get pattern => RegExp(r"I expect to be logged in");
}*/