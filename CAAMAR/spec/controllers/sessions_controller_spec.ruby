require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'POST #create' do
    context 'with valid credentials' do
      let(:user) { create(:usuario, email: 'test@example.com', senha: 'password') }
      
      before do
        post :create, params: { email: user.email, senha: user.senha }
      end
      
      it 'logs in the user' do
        expect(session[:user_id]).to eq(user.id)
      end
      
      it 'redirects to avaliacoes_path with happy alert message' do
        expect(response).to redirect_to(avaliacoes_path(alert_message_happy: "Parabéns princeso vc está logado"))
      end
    end
    
    context 'with invalid credentials' do
      before do
        post :create, params: { email: 'invalid@example.com', senha: 'wrongpassword' }
      end
      
      it 'does not log in the user' do
        expect(session[:user_id]).to be_nil
      end
      
      it 'redirects to root_path with alert message' do
        expect(response).to redirect_to(root_path(alert_message: "Email ou senha incorretos. Tente novamente"))
      end
    end
  end
end
