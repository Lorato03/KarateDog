# new feature
# Tags: optional

Feature: A description

  Background:
    * url 'https://api.thedogapi.com/v1/'
    * header x-api-key = 'live_PyZTkIHmfKfUpzzuobIumQK4klHqVJ4SPtpV0ZbAJahvw8rDngmwigGp4DYZEt4I'
    * header 'Content-Type' = 'application/json'


  Scenario: get all categories and then get the first category by id
    Given path 'categories'
    When method get
    Then status 200

