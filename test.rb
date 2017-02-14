


scenario = "Verify the user gets an error message when searching for past date flights"
p screenshot = "#{scenario.gsub(' ','_').gsub(/[^0-9A-Za-z_]/,'')}.png"