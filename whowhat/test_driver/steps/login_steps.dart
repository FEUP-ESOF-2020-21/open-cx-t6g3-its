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
    final emailField = find.byValueKey('email');
    await FlutterDriverUtils.tap(context.world.driver, emailField);
    await FlutterDriverUtils.enterText(context.world.driver, emailField, email);

    final passwordField = find.byValueKey('password');
    await FlutterDriverUtils.tap(context.world.driver, passwordField);
    await FlutterDriverUtils.enterText(context.world.driver, passwordField, password);
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

