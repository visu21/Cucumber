@all
Feature: Expedia Flight Search


  Background:
    Given user is on Expedia Home Page
    When user select the round trip tab under the flight selection
#
#  #Imperative
  @1
  Scenario: Verify the user gets an error message when searching for past date flights
    And  user select Columbus, OH airport for the city columbus in the departure field
    And  user select Cleveland, OH airport for the city cleveland in the arrival field
#    And  user enter past date in the Departure field
#    And  user enter past date in the Arrival field
    And user searches for past date flights
    And user searches for the avilable flights
    Then verify the Departing date is in the past. Please enter a valid departing date.. message is displayed

#  Declarative
  @2
  Scenario: Verify the user gets an error message when searching for past date flight
    When use searches for a past flights for Cleveland, OH with city cleveland in the departure field
    Then verify the user is warned with a message


  #Declarative - Example -2
  @3
  Scenario: Verify the user gets available search result - calling everything from one place
    When user searches for a (feature OR past) flights for <airport_name> with city <city_name> in the (departure OR arrival) field
    Then verify the user gets the correct details for <arr_city>

    @4
   Scenario Outline: Verify the user gets the avaliable flights for the airport searched
    And  user select <dep_airport> airport for the city <dep_city> in the departure field
    And  user select <arr_airport> airport for the city <arr_city> in the arrival field
#    And  user enter <date> date in the Departure field
#    And  user enter <date> date in the Arrival field
    And  user searches for feature date flights
    And user searches for the avilable flights
    Then verify the user gets the correct details for <arr_city>

    Examples:
      | dep_city | arr_city | dep_airport  | arr_airport |
      | Columbus | Atlanta  | Columbus, OH | Atlanta, GA |
      | Columbus | Chicago  | Columbus, OH | Chicago, IL |
#
#
# # Inline Table
  @5
  Scenario: Verify the user gets an error messages when searching for flights with no data
    And user searches for past date flights
    And  user searches for the avilable flights
    Then verify the error_message is displayed
      | error_message                                                       |dates|
#      | Please complete the highlighted origin field below.           |21321|
#      | Please complete the highlighted destination field below.      |13213|
      | Departing date is in the past. Please enter a valid departing date. |23213|
      | Returning date is in the past. Please enter a valid returning date. |33233|
#
#
  @6
  Scenario: verify the flight search results are sorted by price
    And  user select Columbus, OH airport for the city columbus in the departure field
    And  user select Cleveland, OH airport for the city cleveland in the arrival field
    And user searches for feature date flights
    And user searches for the avilable flights
    Then verify the flight search results are sorted by price
#
#
  @7
    Scenario: Testing the yml functionality
      Then Verify the yml functionality works