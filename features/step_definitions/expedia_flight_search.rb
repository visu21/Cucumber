Given(/^user is on Expedia Home Page$/) do
  visit ExpediaHomePage
end

When(/^user select the round trip tab under the flight selection$/) do
  # @browser.link(:id=>'tab-flight-tab').click

  on(ExpediaHomePage).select_flight_tab
  on(ExpediaHomePage).select_round_trip_flight_element.click
end

And(/^user select (.*)airport for the city (.*) in the (departure|arrival) field$/) do |airport_name, city_name, dep_arr|
  if dep_arr == 'departure'
    on(ExpediaHomePage).set_dep_airport city_name, airport_name
  else
    on(ExpediaHomePage).set_arr_airport city_name, airport_name
  end
end

# And(/^user enter (.*) date in the (.*) field$/) do |feature_or_past, dep_arr|
#   if feature_or_past == 'past'
#     on(ExpediaHomePage).set_dep_date -2
#     on(ExpediaHomePage).set_arr_date -2
#   else
#     on(ExpediaHomePage).set_dep_date 2
#     on(ExpediaHomePage).set_arr_date 2
#   end

And(/^user searches for the avilable flights$/) do
  on(ExpediaHomePage).search_flight_element.click
end

Then(/^verify the ([^"]*) message is displayed$/) do |error_message|
  # on(ExpediaHomePage).verify_error_message error_message
  all_error_messages = on(ExpediaHomePage).get_error_message
  fail "#{all_error_messages} does not include #{message['error_message']}" unless all_error_messages.include? error_message
end

And(/^user searches for (past|feature) date flights$/) do |feature_or_past|
  if feature_or_past == 'past'
    on(ExpediaHomePage).set_dep_date -2
    on(ExpediaHomePage).set_arr_date -2
  else
    on(ExpediaHomePage).set_dep_date 2
    on(ExpediaHomePage).set_arr_date 2

  end
end

Then(/^verify the user gets the correct details for (.*)$/) do |arr_city|
  on(ExpediaSearchResultsPage).verify_search_results_are_correct? arr_city
  p "arrival_city is #{arr_city} to compair"
end


Then(/^verify the error_message is displayed$/) do |table|
  # table is a table.hashes.keys # => [:error_message]
  table.hashes.each do |message|
    p message['error_message']
    # p message['dates']

    all_error_messages = on(ExpediaHomePage).get_error_message
    fail "#{all_error_messages} does not include #{message['error_message']}" unless all_error_messages.include? message['error_message']
  end
end


When(/^use searches for a past flights for (.*) with city (.*) in the departure field$/) do |airport_name, city_name|
  step "user select #{airport_name} airport for the city #{city_name} in the departure field"
end

Then(/^verify the user is warned with a message$/) do
  all_error_messages = on(ExpediaHomePage).get_error_message
  expect(all_error_messages).should include 'Departing date is in the past. Please enter a valid departing date'
end

Then(/^verify the flight search results are sorted by price$/) do
  actual_prices = on(ExpediaSearchResultsPage).get_flight_prices
  expect(actual_prices).should eq actual_prices.sort
end


Then(/^Verify the yml functionality works$/) do
  on(ExpediaHomePage).load_data_using_yml
end

When(/^user searches for a \(feature OR past\) flights for (.*) with city (.*) in the \(departure OR arrival\) field$/) do |airport_name, city_name|
  on(ExpediaHomePage).search_for_flight 10
end