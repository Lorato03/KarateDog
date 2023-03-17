# new feature
# Tags: optional

Feature: A description

  Background:
    * url 'https://api.thedogapi.com/v1/'
    * header x-api-key = 'live_PyZTkIHmfKfUpzzuobIumQK4klHqVJ4SPtpV0ZbAJahvw8rDngmwigGp4DYZEt4I'
    * header 'Content-Type' = 'application/json'

@Lerato
  Scenario: get all favourites
    Given path 'favourites'
    When method get
    Then status 200

@Lerato
  Scenario: get all favourites and then get the first favourite by id
    Given path 'favourites'
    When method get
    Then status 200

    * def first = response[0]

    Given path 'favourites', first.id
    When method get
    Then status 200

  @Lerato
  Scenario: create new favourite and get it by sub_id
    * def favourite =
    """
    {
	"image_id":"9ccXTANkz",
	"sub_id": "my-user-12347"
}
    """
    Given path 'favourites'
    And request favourite
    When method post
    Then status 201

    * def sub_id = response.sub_id
    * print 'created sub_id: ', sub_id

    Given path sub_id
    When method get
    Then status 200
    And match response contains favourite

    @Lerato
  Scenario: create new favourite without sub_id and get it by image_id
    * def favouriteTwo =
    """
    {
	"image_id":"9ccXTANkz"
}
    """
    Given path 'favourites'
    And request favouriteTwo
    When method post
    Then status 201

    * def image_id = response.image_id
    * print 'created image_id: ', image_id

    Given path image_id
    When method get
    Then status 200
    And match response contains favourite

@Lerato
    Scenario: Getting all favourites and deleting a favourite by id
      Given path 'favourites'
      When method get
      Then status 200

      * def toDel = response[0]

      Given path 'favourites', toDel.id
      When method del
      Then status 200
