Feature: Insert Code

  Scenario: insert a code that gives access to a session
    Given an existing session code
    When I insert the code
    And I tap the "connect" button
    Then I have access to the session