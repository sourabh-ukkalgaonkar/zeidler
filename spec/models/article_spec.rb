require 'rails_helper'

RSpec.describe Article, type: :model do
  it { should validate_presence_of(:title) }
  it { should belong_to(:user) }
  it { should have_many(:categories).through(:article_categories) }
end
