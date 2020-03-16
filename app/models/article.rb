class Article < ApplicationRecord
  validates :title, presence: true
  enum status: [:draft, :published, :archived]

  belongs_to :user
  has_many :article_categories
  has_many :categories, through: :article_categories
end
