import 'dart:async';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:gherkin/gherkin.dart';


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

class EnterCredentials extends When2WithWorld<String, String, FlutterWorld> {
  @override
  Future<void> executeStep(String email, String password) async {

    final emailFinder = find.byValueKey(email);
    final passwordFinder = find.byValueKey(password);

    var present1 = await FlutterDriverUtils.isPresent(world.driver, emailFinder);
    var present2 = await FlutterDriverUtils.isPresent(world.driver, passwordFinder);

    expectMatch(true, present1);
    expectMatch(true, present2);
  }

  @override
  RegExp get pattern => RegExp(r"I enter {string} as my email and {string} as my password");
}

// And I tap the "log in" button

class UserTapsButton extends When1WithWorld<String, FlutterWorld> {
  @override
  Future<void> executeStep(String button) async {
    final locator = find.byValueKey(button);
    await world.driver.tap(locator);
  }

  @override
  RegExp get pattern => RegExp(r"I tap the {string} button");
}

