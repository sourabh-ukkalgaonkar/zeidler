require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let!(:user) {
    User.create(name: 'Tester',
    email: 'tester@yopmail.com',
    password: '123456',
    password_confirmation: '123456')
  }

  describe 'new#action' do
    it 'should return login template' do
      get :new
      expect(response).to render_template('new')
    end
  end

  describe 'create#action' do
    it 'should login the user' do
      post :create, params: { email: user.email, password: '123456' }
      expect(response).to redirect_to('/')
      expect(assigns(:user)).to eq(user)
    end

    it 'should not login the user with invalid user email' do
      post :create, params: { email: 'asdsd', password: '123456' }
      expect(response).to render_template('new')
      expect(assigns(:error)).to eq(true)
    end

    it 'should not login the user with wrong password' do
      post :create, params: { email: user.email, password: 'asd' }
      expect(response).to render_template('new')
      expect(assigns(:error)).to eq(true)
    end
  end
end
