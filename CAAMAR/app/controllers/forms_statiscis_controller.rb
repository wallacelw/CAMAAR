class FormsStatiscisController < ApplicationController
  def index
    @answers = JSON.parse(File.read("db/json/answers.json"))
    @forms = JSON.parse(File.read("db/json/forms.json"))
  end



end

