Feature: Booking Creation API Tests

  Background:
    * def baseUrl = 'https://automationintesting.online/api'

  Scenario: Create a new booking successfully
    # Find a valid room ID first
    Given url baseUrl + '/room'
    When method get
    Then status 200
    * def roomId = response.rooms[0].roomid

    # Create booking with required fields
    # Note: Karate auto-sets Content-Type: application/json for JSON payloads
    Given url baseUrl + '/booking'
    And request
    """
    {
      "roomid": #(roomId),
      "firstname": "Antonio",
      "lastname": "Banderas",
      "depositpaid": true,
      "bookingdates": {
        "checkin": "2026-06-01",
        "checkout": "2026-06-05"
      }
    }
    """
    When method post
    Then status 201