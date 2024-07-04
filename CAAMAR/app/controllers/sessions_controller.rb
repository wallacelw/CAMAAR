class SessionsController < ApplicationController
    # Encerra a sessão do usuário atual e redireciona para a página inicial.
    def destroy
        logout current_user
        redirect_to root_path notice: "Tu deslogou"
    end
    
     # Autentica o usuário com base nas credenciais fornecidas e redireciona para a página apropriada.
    def create
        user = Usuario.find_by(email: params[:email],senha:params[:senha])
        if user
            login user
            redirect_to avaliacoes_path(alert_message_happy: "Parabéns princeso vc está logado")
            Rails.logger.info("usuario aqui oh: #{current_user[:senha]}")
        else
            Rails.logger.info("Falhou bruxo: #{params[:email]}")
    
            redirect_to root_path(alert_message: "Email ou senha incorretos. Tente novamente")

        end
    end

     # Renderiza o formulário de login, opcionalmente exibindo mensagens de alerta.
    def new
        @alert_message = params[:alert_message] if params[:alert_message].present?
        @alert_message_happy = params[:alert_message_happy] if params[:alert_message_happy].present?
    end

end