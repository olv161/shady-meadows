Feature: Booking Creation API Tests

  Background:
    * def baseUrl = 'https://automationintesting.online/api'

  Scenario: Create a new booking successfully
    # Find a valid room ID first
    Given url baseUrl + '/room'
    When method get
    Then status 200
    * def roomId = response.rooms[0].roomid

    # Generate future dates using Java LocalDate
    * def LocalDate = Java.type('java.time.LocalDate')
    * def checkin = LocalDate.now().plusDays(180).toString()
    * def checkout = LocalDate.now().plusDays(183).toString()

    # Create booking
    # Note: Karate auto-sets Content-Type: application/json for JSON payloads
    Given url baseUrl + '/booking'
    And request
    """
    {
      "roomid": #(roomId),
      "firstname": "Antonio",
      "lastname": "Banderas",
      "depositpaid": true,
      "email": "antonio@test.com",
      "phone": "01onal2345678",
      "bookingdates": {
        "checkin": "#(checkin)",
        "checkout": "#(checkout)"
      }
    }
    """
    When method post
    Then status 201