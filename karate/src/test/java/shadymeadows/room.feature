Feature: Room Inventory API Tests
  Validate room information is available for viewing

  Background:
    * url 'https://automationintesting.online/api/room'

  Scenario: Verify rooms endpoint returns an array
    Given path ''
    When method get
    Then status 200
    And match response.rooms == '#array'
    And print 'Total rooms found:', response.rooms.length

  Scenario: Verify at least one room exists
    Given path ''
    When method get
    Then status 200
    And match response.rooms == '#[_ > 0]'
    And print 'Number of rooms:', response.rooms.length

  Scenario: Verify room has price greater than 0
    Given path ''
    When method get
    Then status 200
    # Get first room and verify price
    * def firstRoom = response.rooms[0]
    And match firstRoom.roomPrice == '#number'
    And assert firstRoom.roomPrice > 0
    And print 'First room price:', firstRoom.roomPrice