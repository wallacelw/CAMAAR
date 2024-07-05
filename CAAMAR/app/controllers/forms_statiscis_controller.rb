class FormsStatiscisController < ApplicationController
  def index
    @forms = JSON.parse(File.read("C:/Users/luisf/Documents/Eng Software/study/Test/db/json/forms.json"))
  end



end

