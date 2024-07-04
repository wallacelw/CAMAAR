
class UsuariosController < ApplicationController
  before_action :verify_authenticity_token, :set_usuario, only: %i[ show edit update destroy ]

  # GET /usuarios or /usuarios.json
  # Lista todos os usuários cadastrados.
  def index
    @usuarios = Usuario.all
  end

  # GET /usuarios/1 or /usuarios/1.json
  # Exibe os detalhes de um usuário específico.
  def show
  end

  # GET /usuarios/new
  # Renderiza o formulário para criar um novo usuário.
  def new
    @usuario = Usuario.new
  end

  # GET /usuarios/1/edit
  # Renderiza o formulário para criar um novo usuário.
  def edit
  end

  # POST /usuarios or /usuarios.json
  # Cria um novo usuário com base nos parâmetros fornecidos.
  def create
    Rails.logger.info("esse aluno: #{usuario_params}")
    @usuario = Usuario.new(usuario_params)

    respond_to do |format|
      if @usuario.save
       # Se o usuário for salvo com sucesso, redireciona para a página do usuário com uma mensagem de sucesso.
        format.html { redirect_to(@usuario, notice: 'User was successfully created.') }
        format.json { render json: @user, status: :created, location: @user }
      else
         # Se houver erros ao salvar, renderiza novamente o formulário de criação com os erros exibidos.
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @usuario.errors, status: :unprocessable_entity }
      end
    end
  end
    
  def usuario_params
    params.require(:usuario).permit({:usuario =>[:matricula, :nome, :formacao, :email, :senha,:curso,:isAdmin,:isAluno,:isProf]})
  end

  # PATCH/PUT /usuarios/1 or /usuarios/1.json
  # Atualiza os dados de um usuário existente com base nos parâmetros fornecidos.
  def update

    respond_to do |format|
      if @usuario.update(usuario_params)
        format.html { redirect_to usuario_url(@usuario), notice: "Usuario was successfully updated." }
        format.json { render :show, status: :ok, location: @usuario }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @usuario.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /usuarios/1 or /usuarios/1.json
  # Remove um usuário existente do sistema.
  def destroy
    @usuario.destroy!

    respond_to do |format|
      format.html { redirect_to usuarios_url, notice: "Usuario was successfully destroyed." }
      format.json { head :no_content }
    end
  end


  #
  ## Pega o arquivo, extrai os alunos e cria usuários no banco
  def getJson
    file = File.read('db/json/class_members.json')
    data_hash = JSON.parse(file)
    alunos = data_hash[0]['dicente']

    alunos.each do |aluno|
      Rails.logger.info("esse aluno: #{aluno}")
      @usuario = Usuario.new(
        matricula: aluno["matricula"],
        nome: aluno["nome"],
        formacao: aluno["formacao"],
        curso: aluno["curso"],
        email: aluno["email"],  
        senha: aluno["senha"]
      )

      if @usuario.save
        Rails.logger.info("deu bom")
      else
        Rails.logger.info("deu ruim")
      end
      
    end
  end

  private
    
    # Configura o usuário com base no parâmetro :id.
    def set_usuario
      @usuario = Usuario.find(params[:id])
    end

    # Define os parâmetros permitidos para criação/atualização de usuários.
    def usuario_params
      params.require(:usuario).permit(:matricula, :nome, :email, :formacao,:senha,:curso, :isAdmin,:isProf,:isAluno)
    end
end
