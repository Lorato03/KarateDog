# new feature
# Tags: optional

Feature: A description

  Background:
    * url 'https://api.thedogapi.com/v1/'

  Scenario: get all breeds and then get the first breed by id
    Given path 'breeds'
    When method get
    Then status 200

  * def first = response[0]

  Given path 'breeds', first.id
  When method get
  Then status 200

#  Scenario: create new breed and get it by id
  * def breed =
    """
    {
      "name:" "French bulldog"
      }
    """
    Given path 'breeds'
    And request breed
    When method post
    Then status 201

    * def id = response.id
    * print 'created id: ', id

    Given path id
    When method get
    Then status 200
    And match response contains breed


