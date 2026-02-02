Feature: Branding Verification API Tests
  Validate that Shady Meadows B&B branding information is displayed properly

  Background:
    * url 'https://automationintesting.online/api/branding/'

  Scenario: Verify B&B branding information returns correctly
    Given path ''
    When method get
    Then status 200
    And match response.name == 'Shady Meadows B&B'
    And match response.contact.email == 'fake@fakeemail.com'
    And match response.contact.phone == '012345678901'
    And match response.description contains 'Welcome to Shady Meadows, a delightful Bed & Breakfast nestled in the hills on Newingtonfordburyshire. A place so beautiful you will never want to leave. All our rooms have comfortable beds and we provide breakfast from the locally sourced supermarket. It is a delightful place.'

  Scenario: Verify contact email matches valid email format
    Given path ''
    When method get
    Then status 200
    And match response.contact.email == '#regex [a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}'

  Scenario: Verify all branding fields are present
    Given path ''
    When method get
    Then status 200
    And match response contains
    """
    {
      name: '#string',
      map: '#object',
      logoUrl: '#string',
      description: '#string',
      directions: '#string',
      contact: '#object',
      address: '#object'
    }
    """

  Scenario: Verify contact details structure
    Given path ''
    When method get
    Then status 200
    And match response.contact contains
    """
    {
      name: '#string',
      phone: '#string',
      email: '#string'
    }
    """

  Scenario: Verify address structure
    Given path ''
    When method get
    Then status 200
    And match response.address contains
    """
    {
      line1: '#string',
      line2: '#string',
      postTown: '#string',
      county: '#string',
      postCode: '#string'
    }
    """