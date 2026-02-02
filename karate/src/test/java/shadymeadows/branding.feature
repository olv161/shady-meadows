@branding
Feature: Branding Verification API Tests
  As a user of Shady Meadows B&B
  I want to verify the branding information is correct
  So that the B&B identity is properly displayed

  Background:
    * url brandingUrl
    * configure headers = headers

  Scenario: Verify B&B branding information returns correctly
    Given path ''
    When method get
    Then status 200
    And match response.name == 'Shady Meadows B&B'
    And match response contains { name: '#string', description: '#string' }

  Scenario: Verify contact email matches valid email format
    Given path ''
    When method get
    Then status 200
    # Validate email format using regex
    And match response.contact.email == '#regex [a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}'

  Scenario: Verify all branding fields are present
    Given path ''
    When method get
    Then status 200
    And match response contains 
    """
    {
      name: '#string',
      map: '#present',
      logoUrl: '#string',
      description: '#string',
      contact: '#object'
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
      address: '#string',
      phone: '#string',
      email: '#string'
    }
    """

  Scenario: Verify branding name is exactly 'Shady Meadows B&B'
    Given path ''
    When method get
    Then status 200
    And match response.name == 'Shady Meadows B&B'
    And print 'Branding name verified:', response.name
