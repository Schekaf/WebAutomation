Feature: Web Automation with Behave

  Scenario: Open Kitapyurdu
    Given I open Kitapyurdu HomePage
    Then the title should be "Kitapyurdu, Kitapla buluşmanın en kolay yolu"
