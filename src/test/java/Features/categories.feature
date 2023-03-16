# new feature
# Tags: optional

Feature: A description

  Background:
    * url 'https://api.thedogapi.com/v1/'

  Scenario: get all categories and then get the first category by id
    Given path 'categories'
    When method get
    Then status 200

    * def firsT = response[0]

    Given path 'categories', firsT.id
    When method get
    Then status 200