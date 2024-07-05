# Helper para as views de avaliações
module AvaliacoesHelper
  # Recupera o solver de uma avaliação
  def get_solver_from_form(form, user_id)
    form["solvers"].find { |solver| solver["id"] == user_id }
  end

  # Recupera as forms não respondidas pelo usuário
  def get_unanswered_forms(forms, user_id)
    forms.select do |form|
      solver = get_solver_from_form(form, user_id)
      !solver.nil? && !solver["is_solved"]
    end
  end
end
