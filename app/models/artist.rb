class Artist < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :songs
  has_many :streams, through: :songs

  after_create_commit :create_stripe_account # Every time an artist signs up this call back will run

  enum :stripe_status, [ "awaiting_onboarding", "payouts_enabled" ]

  def create_stripe_account
    stripe_account = Stripe::Account.create()
    update(stripe_account_id: stripe_account.id)
  end
end
