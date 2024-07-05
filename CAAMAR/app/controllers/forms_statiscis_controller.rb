class FormsStatiscisController < ApplicationController
  def index
    @forms = JSON.parse(File.read("db/json/forms.json"))
  end

  def form
    answers = JSON.parse(File.read("db/json/answers.json"))
    templates = JSON.parse(File.read("db/json/templates.json"))
    form_id_to_find = params["form_id_to_find"].to_i
    @form = JSON.parse(File.read("db/json/forms.json")).find {|form| form["id"] == form_id_to_find}
    @contador = {}
    @template = templates.find {|template| template["id"] == params['template_id'].to_i}
    @template["questions"].each do |question|
      if question["type"] == "open"
        @contador[question["id"]] ={
          "type" => "open"
        }
      else
        @contador[question["id"]] = {
          "type" => "radio_button",
          "n_respostas" => 0
        }
        question["options"].each do |option|
          @contador[question["id"]][option] = 0
        end
      end
    end
    @answers = answers
    answers.each do |answer|
      if answer["form_id"] == form_id_to_find
        answer["questions"].each do |question|
          if @contador[question["question_id"]]["type"] != "open"
            @contador[question["question_id"]]["n_respostas"] += 1
            @contador[question["question_id"]][question["answer"]] += 1
          end
        end
      end
    end

  end

end


