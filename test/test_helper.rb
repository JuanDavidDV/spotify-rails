ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "webmock/minitest"
include WebMock::API

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  end
  class ActionDispatch::IntegrationTest
    include Devise::Test::IntegrationHelpers
  end
end

# This section is created to mainly for system tests:
WebMock.disable_net_connect!(allow_localhost: true)

Stripe.api_key = "sk_test_1234567890fake"

# Stub ALL requests to Stripe API
stub_request(:any, /api.stripe.com/).to_return(
  status: 200,
  body: {
    client_secret: "test123"
}.to_json, # dummy empty JSON response
  headers: { "Content-Type" => "application/json" }
)
