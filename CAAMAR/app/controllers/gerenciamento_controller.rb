require 'zip'
require 'csv'

# Controller para a página de gerenciamento, onde o administrador pode visualizar os templates de formulários, gerar CSVs com as respostas dos formulários e visualizar os resultados dos formulários.
class GerenciamentoController < ApplicationController
    def index
        unless helpers.is_user_admin()
            redirect_to "/"
            return
        end
    end

    def show_templates
        unless helpers.is_user_admin()
            redirect_to "/"
            return
        end
        
        if File.file?('db/json/templates.json')
            path = 'db/json/templates.json'
            data = File.read(path)
            @templates = JSON.parse(data)
        else
            @templates = []
        end
    end

    def results_popup
        forms = []
        if File.file?('db/json/forms.json')
            all_forms = JSON.parse(File.read('db/json/forms.json'))
            forms = helpers.get_forms_info(all_forms)
        end

        render partial: 'results_popup', layout: false, locals: { forms: forms }
    end

    def generate_csv
        selected_form_ids = []
        params.each do |key, value|
          if key.start_with?("form_id-") && value == "1"
            form_id = key.split("-").last.to_i
            selected_form_ids << form_id
          end
        end

        all_answers = []
        if File.file?('db/json/answers.json')
            all_answers = JSON.parse(File.read('db/json/answers.json'))
        end
        all_forms = []
        if File.file?('db/json/forms.json')
            all_forms = JSON.parse(File.read('db/json/forms.json'))
        end

        csvs = {}
        selected_form_ids.each do |form_id|
            headers = []
            rows = all_answers
                .select { |ans| ans['form_id'] == form_id }
                .map do |form_answer|
                    row = {}
                    form_answer["questions"].each do |answer|
                        question_id = answer['question_id']
                        headers[question_id - 1] ||= "question_#{question_id}_answer"
                        row["question_#{question_id}_answer"] = answer['answer']
                    end
                    row
                end
    
            csv_string = CSV.generate(headers: true) do |csv|
                csv << headers
                rows.each { |row| csv << row.values_at(*headers) }
            end
    
            form = all_forms.find { |form| form["id"] == form_id } # If it gets here, the form is guaranteed to exist
            form_class = form["class"]
            file_name = "#{form_class["subject_code"]} #{form_class["semester"]} #{form_class["code"]} #{form["type"]}.csv"
            file_name = file_name.gsub(/[^0-9A-Za-z.\-]/, '_')
            csvs[file_name] = csv_string
        end

        r_root = Rails.root
        temp_dir = r_root.join('tmp', 'csvs')
        FileUtils.mkdir_p(temp_dir) unless File.directory?(temp_dir)

        csvs.each do |file_name, csv_data|
            File.open(temp_dir.join(file_name), 'w') { |file| file.write(csv_data) }
        end

        zip_file = r_root.join('tmp', 'CSVs.zip')
        File.delete(zip_file) if File.exist?(zip_file)
        Zip::File.open(zip_file, Zip::File::CREATE) do |zip|
            csvs.each do |f_name, _|
                zip.add(f_name, temp_dir.join(f_name))
            end
        end

        send_file zip_file
    end
  end
  