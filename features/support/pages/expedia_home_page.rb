require_relative '../modules/utilities'

class ExpediaHomePage
  include PageObject
  include Utilities

  page_url 'www.expedia.com'

  link(:select_flight_tab, :id =>'tab-flight-tab')
  label(:select_round_trip_flight, :id => 'flight-type-roundtrip-label')
  text_field(:departure_airport, :id => 'flight-origin')
  text_field(:arrival_airport, :id => 'flight-destination')
  ul(:flight_results, :class => 'results')
  text_field(:dep_date, :id => 'flight-departing')
  text_field(:arr_date, :id => 'flight-returning')
  button(:search_flight, :id => 'search-button')
  links(:error_messages, :class => 'dateBeforeCurrentDateMessage')



  def set_dep_airport city_name, airport_name
    # @browser.text_field(:id => 'flight-origin').set city_name
    self.departure_airport = city_name
    # @browser.text_field(:id => 'flight-origin').send_keys :end
    departure_airport_element.send_keys :end
    select_airport_from_list airport_name
  end


  def set_arr_airport city_name, airport_name
    # @browser.text_field(:id => 'flight-destination').set city_name
    self.arrival_airport = city_name
    # @browser.text_field(:id => 'flight-destination').send_keys :end
    arrival_airport_element.send_keys :end
    select_airport_from_list airport_name
  end

  def select_airport_from_list airport_name
    flight_results_element.when_present.list_item_elements.each do |airport|
      # p airport.text
      if airport.text.include? airport_name
        airport.click
        break
      end
    end
  end

  def set_dep_date no_of_days
    date = convert_time no_of_days
    @browser.text_field(:id => 'flight-departing').set date
    # dep_date_element date
  end

  def set_arr_date no_of_days
    date = convert_time no_of_days
    @browser.text_field(:id => 'flight-returning').set date
    # arr_date_element date
  end

  # def verify_error_message error_message
  #   error_messages_elements.each do |message|
  #     p message.text
  #     if message.text.include? error_message
  #       break
  #     else
  #       fail "#{error_message} is not same as #{message.text}"
  #     end
  #   end
  #   end

  def get_error_message
    error_messages_elements.map do |error_msg|
      error_msg.text
    end
  end

  # def load_data_using_yml
  #   path = 'C:\RubymineProjects\All_projects\expedia_po_sep_2016\features\support\test_data.yml'
  #   @file = YAML.load_file(path)
  #
  #   p @file.fetch('request')
  #   p @file['company']
  #   p @file['QA']['city_name']
  #   File.open(path, 'w') {|f| f.write(@file.to_yaml)}
  #
  #   @file['company'] = 'bank'
  #   p 'after update'
  #   p @file.fetch('company')
  # end


  def load_data_using_yml
    path = 'C:\RubymineProjects\All_projects\expedia_po_sep_2016\features\support\test_data.yml'
    @file = YAML.load_file(path)
  end

  def search_for_flight no_of_days
    set_dep_airport 'chicago','Chicago, IL'
    set_arr_airport 'cleveland','Cleveland, OH'
    set_dep_date no_of_days
    set_arr_date no_of_days
    search_flight_element.click
  end

  # def search_for_flight no_of_days
  #   @data = load_data_using_yml
  #   set_dep_airport @data['QA']['city_name'],@data['QA']['airport_name']
  #   # set_dep_airport 'chicago','Chicago, IL'
  #   set_arr_airport @data['DEV']['city_name'],@data['DEV']['airport_name']
  #   # set_arr_airport 'cleveland','Cleveland, OH'
  #   set_dep_date no_of_days
  #   set_arr_date no_of_days
  #   search_flight_element.click
  # end

  end
