class Article < ApplicationRecord
  validates :title, presence: true
  enum status: [:draft, :published, :archived]

  belongs_to :user
end
