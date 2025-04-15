require "test_helper"

class WebhookEventTest < ActiveSupport::TestCase
  test "should load fixtures correctly" do
    webhook = webhook_events(:one)
    assert_equal "stripe", webhook.source
    assert_equal "payment_intent.succeeded", webhook.data["event_type"]
    assert_equal "pending", webhook.status
  end

  test "should serialize data as a Hash" do
    webhook = webhook_events(:two)
    assert_kind_of Hash, webhook.data
    assert_equal true, webhook.data["details"]["payouts_enabled"]
  end

  test "should allow setting and retrieving status enum" do
    webhook = webhook_events(:three)
    assert_equal "failed", webhook.status

    webhook.processed!
    assert_equal "processed", webhook.status
  end

  test "should be valid with all required fields" do
    webhook = WebhookEvent.new(
      source: "stripe",
      data: { "event_type" => "customer.created" },
      status: :pending
    )
    assert webhook.valid?
  end

  test "should default to pending status" do
    webhook = WebhookEvent.create!(
      source: "stripe",
      data: { "event_type" => "invoice.paid" }
    )
    assert_equal "pending", webhook.status
  end
end
