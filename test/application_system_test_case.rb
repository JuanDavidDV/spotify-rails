require "test_helper"
WebMock.allow_net_connect!

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  # Disable webdrivers auto-download since we're using system Chromium
  Webdrivers.install_dir = "/usr/bin" # Point to where chromedriver is installed
  Webdrivers::Chromedriver.required_version = `chromedriver --version`.split[1]

  # Register Chromium driver
  Capybara.register_driver :selenium_chromium do |app|
    options = Selenium::WebDriver::Chrome::Options.new
    options.binary = "/usr/bin/chromium-browser" # Point to Chromium binary
    options.add_argument("--no-sandbox")
    options.add_argument("--disable-dev-shm-usage")
    options.add_argument("--disable-gpu")
    options.add_argument("--window-size=1400,1400")
    options.add_argument("--user-data-dir=#{Dir.mktmpdir}")

    Capybara::Selenium::Driver.new(
      app,
      browser: :chrome,
      options: options
    )
  end

  # Register headless Chromium driver
  Capybara.register_driver :selenium_chromium_headless do |app|
    options = Selenium::WebDriver::Chrome::Options.new
    options.binary = "/usr/bin/chromium-browser"
    options.add_argument("--headless=new")
    options.add_argument("--no-sandbox")
    options.add_argument("--disable-dev-shm-usage")
    options.add_argument("--disable-gpu")
    options.add_argument("--window-size=1400,1400")
    options.add_argument("--user-data-dir=#{Dir.mktmpdir}")

    Capybara::Selenium::Driver.new(
      app,
      browser: :chrome,
      options: options
    )
  end

  # Use the Chromium driver by default
  driven_by :selenium_chromium

  # Configure Capybara for WSL
  Capybara.configure do |config|
    config.server_host = '0.0.0.0'
    config.server_port = 3000
    config.app_host = "http://localhost:3000" # Or use your WSL IP if needed
  end
end
