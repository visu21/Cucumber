class ExpediaSearchResultsPage
  include PageObject


  span(:search_results_header, :class => 'title-city-text')
  spans(:price, :class => 'dollars price-emphasis')
  div(:search_filter, :id=>'filterContainer')
  div(:progress_bar, :class=>'progress-bar')



  def verify_search_results_are_correct? arr_city
    if search_results_header_element.text.eql? "Select your departure to #{arr_city}"
      p "#{arr_city} is match"
    else
      fail "#{arr_city} name is not found in the search results"
    end
  end

  def wait_until_search_result_are_loaded
      wait_until(30){
        p progress_bar_element.div_element.element.attribute_value('style')
        progress_bar_element.div_element.element.attribute_value('style').include? 'width: 100%;'


      }
  end

  def get_flight_prices
    wait_until_search_result_are_loaded
    actual_price = price_elements.map do |price_value|
       (price_value.text).gsub('$','').gsub(',','').to_i
    end
    # p get_flight_prices
    # p get_flight_prices.sort
    # actual_sort = price_elements.map(&:text)
  end
end