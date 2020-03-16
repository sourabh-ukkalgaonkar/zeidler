require 'rails_helper'

RSpec.describe RegistrationsController, type: :controller do
  let!(:user) {
    User.create(name: 'Tester',
    email: 'tester@yopmail.com',
    password: '123456')
  }

  describe 'new#action' do
    it 'should return sign_up template' do
      get :new
      expect(response).to render_template('new')
    end
  end

  describe 'create#action' do
    it 'should sign_up the user with valid params' do
      post :create, params: { user: { name: 'tester', email: 'tester1@yopmail.com', password: '123456' } }
      expect(response).to redirect_to('/')
      expect(assigns(:user).valid?).to be_truthy
    end

    it 'should sign_up the user without valid params' do
      post :create, params: { user: { email: 'asdsd', password: '123456' } }
      expect(response).to render_template('new')
      expect(assigns(:user).valid?).to be_falsey
    end
  end
end
