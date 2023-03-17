# new feature
# Tags: optional

Feature: A description

  Background:
    * url 'https://api.thedogapi.com/v1/'
    * header x-api-key = 'live_PyZTkIHmfKfUpzzuobIumQK4klHqVJ4SPtpV0ZbAJahvw8rDngmwigGp4DYZEt4I'
    * header 'Content-Type' = 'application/json'


  Scenario: get all votes
    Given path 'votes/'
    When method get
    Then status 200


@Lerato
  Scenario: get all votes and then get the second vote by id
    Given path 'votes/'
    When method get
    Then status 200

    * def First = response[1]

    Given path 'votes/', First.id
    When method get
    Then status 200


#    Post for down vote
  @Lerato
  Scenario: create new down vote and get it by sub_id
    * def downVote =
    """
    {
	"image_id":"asz2",
	"sub_id": "my-user-12348",
	"value":0
}
    """
    Given path 'votes/'
    And request downVote
    When method post
    Then status 201

    * def sub_id = response.sub_id
    * print 'created sub_id: ', sub_id

    Given path sub_id
    When method get
    Then status 404
    And match response contains downVote

#    Post for up vote
  @Lerato
  Scenario: create new up vote and get it by sub_id
    * def upVote =
    """
    {
	"image_id":"asx2",
	"sub_id": "my-user-12349",
	"value":2
}
    """
    Given path 'votes/'
    And request upVote
    When method post
    Then status 201

    * def sub_id = response.sub_id
    * print 'created sub_id: ', sub_id

    Given path sub_id
    When method get
    Then status 200
    And match response contains upVote

@Lerato
  Scenario: verify that I can delete vote by id
    Given path 'votes/426'
    And header 'Content-Type' = 'application/json'
    When method delete
    Then status 400
    And eval karate.log('Response:', response)