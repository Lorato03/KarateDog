# new feature
# Tags: optional

Feature: A description

  Background:
    * url 'https://api.thedogapi.com/v1/'

  Scenario: get all votes and then get the first vote by id
    Given path 'votes'
    When method get
    Then status 200

    * def First = response[0]

    Given path 'votes', First.id
    When method get
    Then status 200

  Scenario: get all votes and then get the second vote by id
    Given path 'votes'
    When method get
    Then status 200

    * def First = response[1]

    Given path 'votes', First.id
    When method get
    Then status 200


#    Post for down vote
  Scenario: create new down vote and get it by sub_id
    * def downVote =
    """
    {
	"image_id":"asz2",
	"sub_id": "my-user-12348",
	"value":0
}
    """
    Given path 'votes'
    And request downVote
    When method post
    Then status 201

    * def sub_id = response.sub_id
    * print 'created sub_id: ', sub_id

    Given path sub_id
    When method get
    Then status 200
    And match response contains downVote

#    Post for up vote
  Scenario: create new up vote and get it by sub_id
    * def upVote =
    """
    {
	"image_id":"asx2",
	"sub_id": "my-user-12349",
	"value":2
}
    """
    Given path 'votes'
    And request upVote
    When method post
    Then status 201

    * def sub_id = response.sub_id
    * print 'created sub_id: ', sub_id

    Given path sub_id
    When method get
    Then status 200
    And match response contains upVote

  Scenario: Get all votes and deleting a vote by id
    Given path 'votes'
    When method get
    Then status 200

    * def toDelete = response[0]

    Given path 'favourites', toDelete.id
    When method del
    Then status 200

