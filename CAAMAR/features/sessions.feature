Feature: User Sessions

  Scenario: User logs in successfully
    Given a user with email "banana@gmail.com" and password "12345" exists
    When I log in with email "teste@gmail.com" and password "123"
    Then I should be redirected to the "avaliacoes_path"
    And I should see "Parabéns princeso vc está logado"

  Scenario: User logs out
    Given I am logged in as "user@example.com"
    When I log out
    Then I should be redirected to the "root_path"
    And I should see "Tu deslogou"
