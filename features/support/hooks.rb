require 'watir'

Before do
  @browser = Watir::Browser.new :firefox
  @browser.driver.manage.window.maximize
end

After do
  @browser.close
end

After do |scenario|
  SCREENSHOT_DIRECTORY = "html-report"
  if scenario.failed?
    # @browser.driver.save_screenshot('C:\RubymineProjects\All_projects\expedia_po_sep_2016\features\1.jpg')
    screenshot = "#{scenario.name.gsub(' ','_').gsub(/[^0-9A-Za-z_]/,'')}.png"
    @browser.driver.save_screenshot(File.join(SCREENSHOT_DIRECTORY, screenshot))
    embed(File.join(SCREENSHOT_DIRECTORY,screenshot), "image/png", "SCREENSHOT")
  end
end