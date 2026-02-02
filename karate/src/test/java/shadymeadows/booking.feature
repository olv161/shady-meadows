Feature: Booking Creation API Tests

  Background:
    * def baseUrl = 'https://automationintesting.online/api'

  Scenario: Create a new booking successfully
    # Find a valid room ID first
    Given url baseUrl + '/room'
    When method get
    Then status 200
    * def roomId = response.rooms[0].roomid

    # Generate random future dates to avoid conflicts
    * def LocalDate = Java.type('java.time.LocalDate')
    * def Random = Java.type('java.util.Random')
    * def random = new Random()
    * def randomDays = 10 + random.nextInt(100)
    * def checkin = LocalDate.now().plusDays(randomDays).toString()
    * def checkout = LocalDate.now().plusDays(randomDays + 3).toString()

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
      "phone": "012345678901",
      "bookingdates": {
        "checkin": "#(checkin)",
        "checkout": "#(checkout)"
      }
    }
    """
    When method post
    Then status 201