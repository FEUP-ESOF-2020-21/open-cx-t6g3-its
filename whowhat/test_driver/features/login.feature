Feature: Log In 

  Scenario: Log In when LogIn button pressed
    Given I am in the "Log in" screen
    When I enter my credentials
    And I tap the "log in" button
    Then I expect to be logged in 