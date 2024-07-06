module ApplicationHelper
    def is_user_admin()
        !current_user.nil? ? current_user[:isAdmin] : false
    end
    
    def get_current_user_id()
        !current_user.nil? ? current_user[:matricula] : nil
    end

    def get_forms_info(forms)
        classes = JSON.parse(File.read('db/json/classes.json'))
        class_members = JSON.parse(File.read('db/json/class_members.json'))
        # Add class_data to the filtered forms
        forms.map do |form|
            form_class = form["class"]
            form_class_code = form_class["code"]
            form_class_subject_code = form_class["subject_code"]
            form_class_semester = form_class["semester"]

            class_data = classes.find do |info|
                info_class = info["class"]
                info["code"] == form_class_subject_code &&
                info_class["semester"] == form_class_semester &&
                info_class["classCode"] == form_class_code
            end
            
            teacher_name = (class_members.find do |info|
                info["code"] == form_class_subject_code &&
                info["semester"] == form_class_semester &&
                info["classCode"] == form_class_code
            end)["docente"]["nome"]
            class_data["class"]["teacher_name"] = teacher_name

            form.merge("class_data" => class_data)
        end
    end
end
