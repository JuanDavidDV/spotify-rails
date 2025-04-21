Stripe.api_key = Rails.application.credentials.dig(:stripe, :sk)

# Or for test environment specifically:
if Rails.env.test?
  Stripe.api_key = Rails.application.credentials.dig(:stripe, :sk)
end
