# frozen_string_literal: true

class Article < ApplicationRecord
  validates :title, presence: true
  enum status: %i[draft published archived]

  belongs_to :user
  has_many :article_categories
  has_many :categories, through: :article_categories

  def self.search(search, user = nil)
    records = if user.present?
                user.articles.joins(:categories, :user)
              else
                Article.joins(:categories, :user)
    end

    return records if search.blank?

    if search[:query].present?
      records = records.where('title LIKE ? OR text LIKE ?', "%#{search[:query]}%", "%#{search[:query]}%")
    end

    if search[:user].present?
      records = records.where('users.name LIKE ?', "%#{search[:user]}%")
    end

    if search[:categories].present?
      search[:categories] = search[:categories].split(',').map(&:strip)
      records = records.where('categories.name IN (?)', search[:categories])
    end

    records
  end
end
