class ApplicationController < ActionController::Base
    # private
  
    # Retorna o usuário atualmente logado.
    def current_user
      @current_user ||= authenticate_user_from_session
    end
    helper_method :current_user
  
    # Autentica o usuário com base na sessão atual.
    def authenticate_user_from_session
      Usuario.find_by(id: session[:user_id])
    end
  
    # Verifica se há um usuário logado.
    def user_signed_in?
      current_user.present?
    end
    helper_method :user_signed_in?
  
    # Realiza o login do usuário.
    def login(user)
      @current_user = user
      reset_session
      session[:user_id] = user.id
    end
  
    # Realiza o logout do usuário.
    def logout(user)
      @current_user = nil
      reset_session
    end
  end
  