ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "webmock/minitest"

WebMock.disable_net_connect!(allow_localhost: true)

module ActiveSupport
  class TestCase
    parallelize(workers: :number_of_processors)
    fixtures :all

    setup do
      # Mock Stripe API responses
      stub_request(:post, "https://api.stripe.com/v1/account_sessions")
        .to_return(
          status: 200,
          body: {
            id: "acct_session_123",
            client_secret: "secret_1234567890"
          }.to_json,
          headers: { "Content-Type" => "application/json" }
        )
    end
  end

  class ActionDispatch::IntegrationTest
    include Devise::Test::IntegrationHelpers
  end
end
