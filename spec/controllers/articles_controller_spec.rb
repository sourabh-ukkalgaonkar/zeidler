require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  let(:category) do
    Category.create(name: Faker::Game.title)
  end

  let(:article_attributes) do
    {
      title: Faker::Name.name,
      text: Faker::Address.full_address,
    }
  end

  let!(:user) {
    User.create(name: Faker::Name.name,
    email: Faker::Internet.email,
    password: '123456')
  }

  describe 'new#action' do
    it 'should return login template' do
      allow_any_instance_of(ArticlesController).to receive(:current_user).and_return(user)
      get :new
      expect(response).to render_template('new')
    end
  end

  describe 'create#action' do
    it 'should create a article' do
      allow_any_instance_of(ArticlesController).to receive(:current_user).and_return(user)
      post :create, params: { article: article_attributes.merge!(category_ids: [category.id]) }
      expect(response).to redirect_to(articles_path)
      expect(Article.count).to be(1)
    end

    it 'should not create a article' do
      allow_any_instance_of(ArticlesController).to receive(:current_user).and_return(user)
      post :create, params: { article: {} }
      expect(response).to render_template('new')
      expect(Article.count).to be(0)
    end
  end

  describe 'create#update' do
    it 'should update a article' do
      allow_any_instance_of(ArticlesController).to receive(:current_user).and_return(user)
      article = user.articles.create(title: Faker::Name.name, text: Faker::Address::full_address)
      expect(Article.count).to be(1)
      patch :update, params: {  id: article.id, article: article_attributes.merge!({title: 'tester'}) }
      expect(response).to redirect_to(articles_path)
      expect(Article.count).to be(1)
    end
  end
end