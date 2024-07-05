class Usuario < ApplicationRecord
    validates :matricula, presence: true
    validates :nome, presence: true
    validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :senha, presence: true
    
    attribute :isAdmin, :boolean, default: false
    attribute :isAluno, :boolean, default: false
    attribute :isProf, :boolean, default: false
    attribute :curso, :string
    attribute :departamento, :string
end
