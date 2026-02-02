Feature: Booking Creation API Tests
  Validate booking creation for Shady Meadows B&B rooms

  Background:
    * url 'https://automationintesting.online/api/booking'

  Scenario: Create a new booking successfully
    # Step 1: Find a valid room ID first
    Given path '/room/'
    When method get
    Then status 200
    * def roomId = response.rooms[0].roomid

    # Step 2: Create booking for that room
    Given path '/booking/'
    And header Content-Type = 'application/json'
    And request
    """
    {
      "roomid": #(roomId),
      "firstname": "Antonio",
      "lastname": "Banderas",
      "depositpaid": true,
      "bookingdates": {
        "checkin": "2025-06-01",
        "checkout": "2025-06-05"
      }
    }
    """
    When method post
    Then status 201
    And match response.bookingid == '#number'
    And print 'Booking created with ID:', response.bookingid

  Scenario: Verify booking contains all required fields in response
    # Get valid room ID
    Given path '/room/'
    When method get
    Then status 200
    * def roomId = response.rooms[0].roomid

    # Create booking
    Given path '/booking/'
    And header Content-Type = 'application/json'
    And request
    """
    {
      "roomid": #(roomId),
      "firstname": "Jane",
      "lastname": "Smith",
      "depositpaid": false,
      "bookingdates": {
        "checkin": "2025-07-10",
        "checkout": "2025-07-15"
      }
    }
    """
    When method post
    Then status 201
    And match response.booking contains
    """
    {
      firstname: 'Jane',
      lastname: 'Smith',
      depositpaid: false,
      bookingdates: '#object'
    }
    """

  Scenario: Create booking with dynamic future dates
    # Get valid room ID
    Given path '/room/'
    When method get
    Then status 200
    * def roomId = response.rooms[0].roomid

    # Generate future dates dynamically
    * def today = new Date()
    * def checkinDate = new Date(today.getTime() + 60*24*60*60*1000)
    * def checkoutDate = new Date(today.getTime() + 65*24*60*60*1000)
    * def formatDate = function(d) { return d.toISOString().split('T')[0] }
    * def checkin = formatDate(checkinDate)
    * def checkout = formatDate(checkoutDate)
    * print 'Booking dates:', checkin, 'to', checkout

    Given path '/booking/'
    And header Content-Type = 'application/json'
    And request
    """
    {
      "roomid": #(roomId),
      "firstname": "Dynamic",
      "lastname": "Test",
      "depositpaid": true,
      "bookingdates": {
        "checkin": "#(checkin)",
        "checkout": "#(checkout)"
      }
    }
    """
    When method post
    Then status 201
    And match response.bookingid == '#number'

  Scenario: Verify booking fails without required fields
    Given path '/booking/'
    And header Content-Type = 'application/json'
    And request
    """
    {
      "firstname": "Incomplete"
    }
    """
    When method post
    Then status != 201
    * print 'Expected failure status:', responseStatus