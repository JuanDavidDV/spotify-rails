class StripeController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [ :webhooks ]
  before_action :auth_webhook_request, only: [ :webhooks ]

  def account_session
    account_session = Stripe::AccountSession.create({
      account: current_artist.stripe_account_id,
      components: {
        account_onboarding: {
          enabled: true,
          features: { external_account_collection: true },
        }
      }
    })

    render json: { client_secret: account_session.client_secret }
  end

  def webhooks
    @webhook_event = WebhookEvent.create(source: :stripe, data: @event)
    case @event.type
    when "account.updated"
      if @event["data"]["object"]["payouts_enabled"] == true
        # Update artist account
      end
    else
      puts "Unhandled event type: #{@event.type}"
    end
    @webhook_event.processed!
  end

  private

  def auth_webhook_request  # Code extracted from Stripe website
    payload = request.body.read
    sig_header = request.env["HTTP_STRIPE_SIGNATURE"]

    begin
      @event = Stripe::Webhook.construct_event(
        payload, sig_header, Rails.application.credentials.dig(:stripe, :wh_secret)
      )
    rescue JSON::ParserError => e
      status 400
      return
    rescue Stripe::SignatureVerificationError => e
      status 400
      return
    end
  end
end
