class Song < ApplicationRecord
  belongs_to :artist
  has_one_attached :image, dependent: :destroy # Deletes children
  has_one_attached :audio_file, dependent: :destroy # Deletes children
  has_many :streams, dependent: :destroy # Deletes children
  # Created for tests
  validates :title, presence: true
  validates :audio_file, presence: true
  validates :image, presence: true
end
