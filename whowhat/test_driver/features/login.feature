Feature: Log In 

  Scenario: Log In when LogIn button pressed
    Given I am in the "Log in" screen
    When I enter "sample@gmail.com" as my email and "123456" as my password
    And I tap the "log in" button
    Then I expect to be logged in 