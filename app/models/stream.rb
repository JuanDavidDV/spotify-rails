class Stream < ApplicationRecord
  belongs_to :song
  belongs_to :user, optional: true  # Able to create a stream without a user being sign in
end
