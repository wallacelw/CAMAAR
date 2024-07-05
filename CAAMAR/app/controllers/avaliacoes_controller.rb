# Controller para a página de avaliações
class AvaliacoesController < ApplicationController
  # Renderiza a página de avaliações com as avaliações não respondidas pelo usuário atual
  def index
    @forms = []
    if File.file?('db/json/forms.json')
      all_forms = JSON.parse(File.read('db/json/forms.json'))
      # Filter forms to only show unanswered ones by the current user
      curr_user = helpers.get_current_user_id()
      unanswered_forms = helpers.get_unanswered_forms(all_forms, curr_user)

      @forms = helpers.get_forms_info(unanswered_forms)
    end
  end
end
