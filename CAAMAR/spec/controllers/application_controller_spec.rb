# spec/controllers/application_controller_spec.rb
require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  let(:usuario) { Usuario.create(matricula: '123456', nome: 'Test User', formacao: 'Test Formacao', email: 'test@example.com', senha: 'password', curso: 'Test Curso', isAdmin: false, isAluno: true, isProf: false) }


  before do
    Current.user = nil
  end
  
  describe '#authenticate_user_from_session' do
    it 'returns the user if session contains a valid user_id' do
      session[:user_id] = usuario.id
      expect(controller.send(:authenticate_user_from_session)).to eq(usuario)
    end

    it 'returns nil if session does not contain a valid user_id' do
      session[:user_id] = nil
      expect(controller.send(:authenticate_user_from_session)).to be_nil
    end
  end

  describe '#user_signed_in?' do
    it 'returns true if a user is signed in' do
      session[:user_id] = usuario.id
      expect(controller.send(:user_signed_in?)).to be_truthy
    end

    it 'returns false if no user is signed in' do
      session[:user_id] = nil
      expect(controller.send(:user_signed_in?)).to be_falsey
    end
  end

  describe '#login' do
    it 'sets the current user and session user_id' do
      controller.send(:login, usuario)
      expect(Current.user).to eq(usuario)
      expect(session[:user_id]).to eq(usuario.id)
    end
  end

  describe '#logout' do
    it 'resets the current user and session user_id' do
      controller.send(:login, usuario)
      controller.send(:logout, usuario)
      expect(Current.user).to be_nil
      expect(session[:user_id]).to be_nil
    end
  end
end
