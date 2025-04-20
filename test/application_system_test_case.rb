require "test_helper"
WebMock.allow_net_connect!

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  WINDOWS_HOST = `ip route | grep default | awk '{print $3}'`.strip
  CHROMEDRIVER_URL = "http://#{WINDOWS_HOST}:9515/"
  driven_by :selenium_remote_chrome

  Capybara.register_driver :selenium_remote_chrome do |app|
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--start-maximized')
    options.add_argument('--disable-gpu')
    options.add_argument('--no-sandbox')

    Capybara::Selenium::Driver.new(
      app,
      browser: :remote,
      url: CHROMEDRIVER_URL,  # Use dynamic IP here
      capabilities: options
    )
  end

  Capybara.configure do |config|
    # Match what's set for URL options in test.rb so we can test mailers that contain links.
    config.server_host = 'localhost'
    config.server_port = '3000'
  end
end
