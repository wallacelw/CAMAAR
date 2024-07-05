# spec/controllers/usuarios_controller_spec.rb
require 'rails_helper'

RSpec.describe UsuariosController, type: :controller do
  let(:valid_attributes) do
    {
      matricula: '123456',
      nome: 'Test User',
      formacao: 'Test Formacao',
      email: 'test@example.com',
      senha: 'password',
      curso: 'Test Curso',
      isAdmin: false,
      isAluno: true,
      isProf: false
    }
  end

  let(:invalid_attributes) do
    {
      matricula: '',
      nome: '',
      email: 'invalid',
      senha: '',
      curso: '',
      isAdmin: false,
      isAluno: true,
      isProf: false
    }
  end

  describe 'GET #index' do
    it 'returns a success response' do
      Usuario.create! valid_attributes
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      usuario = Usuario.create! valid_attributes
      get :show, params: { id: usuario.to_param }
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      usuario = Usuario.create! valid_attributes
      get :edit, params: { id: usuario.to_param }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Usuario' do
        expect {
          post :create, params: { usuario: valid_attributes }
        }.to change(Usuario, :count).by(1)
      end

      it 'redirects to the created usuario' do
        post :create, params: { usuario: valid_attributes }
        expect(response).to redirect_to(Usuario.last)
      end
    end

    context 'with invalid params' do
      it 'renders the new template' do
        post :create, params: { usuario: invalid_attributes }
        expect(response).to be_unprocessable
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        {
          nome: 'Updated User'
        }
      end

      it 'updates the requested usuario' do
        usuario = Usuario.create! valid_attributes
        put :update, params: { id: usuario.to_param, usuario: new_attributes }
        usuario.reload
        expect(usuario.nome).to eq('Updated User')
      end

      it 'redirects to the usuario' do
        usuario = Usuario.create! valid_attributes
        put :update, params: { id: usuario.to_param, usuario: valid_attributes }
        expect(response).to redirect_to(usuario)
      end
    end

    context 'with invalid params' do
      it 'renders the edit template' do
        usuario = Usuario.create! valid_attributes
        put :update, params: { id: usuario.to_param, usuario: invalid_attributes }
        expect(response).to be_unprocessable
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested usuario' do
      usuario = Usuario.create! valid_attributes
      expect {
        delete :destroy, params: { id: usuario.to_param }
      }.to change(Usuario, :count).by(-1)
    end

    it 'redirects to the usuarios list' do
      usuario = Usuario.create! valid_attributes
      delete :destroy, params: { id: usuario.to_param }
      expect(response).to redirect_to(usuarios_url)
    end
  end
end
