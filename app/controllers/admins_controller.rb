class AdminsController < ApplicationController

    def index 
        @user = User.find(current_user.id)

        #render :perfil_root
    end

    def index_users
        
        @users = User.all
        render :users
    end

    def index_admin 
        @areas = Area.all
        @plans = Plan.all
    end


    def save

        @area = Area.where("name = ?", "Administración")
        @doctor = Doctor.new(admin_params)
        @doctor.specialty = "administracion"
        @doctor.area_id = @area[0].id
        @doctor.mail = params[:mail]
        @doctor.user_id = params[:user_id]

        if @doctor.save!(:validate => false) 
            redirect_to '/perfilR', notice: "Los datos del perfil fueron guardados satisfactoriamente."
        else
            redirect_to '/perfilR', alert: "Los datos del perfil no pudieron ser guardados."
        end

    end

    def update 

        @doctor = Doctor.find(params[:id])

        if @doctor.update(admin_params)
            redirect_to '/perfilR', notice: "Los datos del perfil fueron actualizados satisfactoriamente."
        else
            redirect_to '/perfilR', alert: "Los datos del perfil no pudieron ser actualizados."
        end
    
    end

    def upload_data_view_patient

        @patients_new = Patient.where("status_file = 'Nuevo Ingreso'")
        @patients_active = Patient.where("status_file = 'Activo'")
        @patients_delete = Patient.where("status_file = 'Egreso'")

        render 'upload_patients'
    end

    def upload_data_view_doctor

        @doctors = Doctor.where("status = 'Masivo'")

        render 'upload_doctors'
    end

    def upload_delete_patient

        name = params[:name].split("-")[0]
        
        if name === "Eliminados"
            #upload_data_save_patient(params[:file_name])
            upload_data_save_patient( {file: params[:file_name], company: params[:name].split("-")[2]} )
        else
            redirect_to '/administracion/carga-masiva', alert: "Por favor cargue el archivo con los pacientes eliminados (Eliminados-Pacientes.csv)."
        end

    end

    def upload_new_patient

        name = params[:name].split("-")[0]

        if name === "Nuevos"
            #upload_data_save_patient(params[:file_name])
            upload_data_save_patient( {file: params[:file_name], company: params[:name].split("-")[2]}  )
        else
            redirect_to '/administracion/carga-masiva', alert: "Por favor cargue el archivo con los pacientes nuevos (Nuevos-Pacientes.csv)."
        end
    
    end

    def upload_active_patient

        name = params[:name].split("-")[0]

        if name === "Activos"
            #upload_data_save_patient(params[:file_name])
            upload_data_save_patient( {file: params[:file_name], company: params[:name].split("-")[2]} )
        else
            redirect_to '/administracion/carga-masiva', alert: "Por favor cargue el archivo con los pacientes activos (Activos-Pacientes.csv)."
        end

    end

    def upload_data_save_patient(obj)

        procesed = false
        message = ""
        company_id = 0
        @patient = Patient.new
        @company = Company.new

        
        if obj[:company] != "" && obj[:company] != nil

            array_object = @patient.get_list_patient_by_csv(obj[:file])
            company_id = @company.get_company_id_by_name(obj[:company].split(".")[0])

            procesed = @patient.save_patient_by_csv({array_object: array_object, company_id: company_id}) 

            if procesed
               redirect_to '/administracion/carga-masiva', notice: " El archivo CSV fue procesado satisfactoriamente."
            else
               redirect_to '/administracion/carga-masiva', alert: " Se generaron problemas con algunos registros durante el proceso."
            end
        else
            redirect_to '/administracion/carga-masiva', alert: "Por favor seleccione un documento correctamente identificado."
        end
       

    end


    def upload_delete_doctor

        name = params[:name].split("-")[0]
        
        if name === "Eliminados"
            upload_data_save_doctor(params[:file_name])
        else
            redirect_to '/administracion/carga-masiva-doctors', alert: "Por favor cargue el archivo con los pacientes eliminados (Eliminados-Medicos.csv)."
        end

    end

    def upload_active_doctor

        name = params[:name].split("-")[0]
        
        if name === "Activos"
            upload_data_save_doctor(params[:file_name])
        else
            redirect_to '/administracion/carga-masiva-doctors', alert: "Por favor cargue el archivo con los pacientes eliminados (Ativos-Medicos.csv)."
        end

    end

    def upload_new_doctor

        name = params[:name].split("-")[0]

        if name === "Nuevos"
           upload_data_save_doctor(params[:file_name])
        else
            redirect_to '/administracion/carga-masiva-doctors', alert: "Por favor cargue el archivo con los pacientes nuevos (Nuevos-Medicos.csv)."
        end
    
    end

    def upload_data_save_doctor(file_name)

        procesed = false
        message = ""
        @doctor = Doctor.new

        @doctor.set_status_masive

        array_object = @doctor.get_list_patient_by_csv(file_name)

        procesed = @doctor.save_patient_by_csv(array_object) 

        if procesed
            redirect_to '/administracion/carga-masiva-doctors', notice: " El archivo CSV fue procesado satisfactoriamente."
        else
            redirect_to '/administracion/carga-masiva-doctors', alert: " Se generaron problemas con algunos registros durante el proceso."
        end

    end

    #otros perfiles administrativos
    def index_perfil_B
        @user = User.find(current_user.id)
        render :perfil_caja
    end

    def save_perfil_B

        @area = Area.where("name = ?", "Administración")
        @doctor = Doctor.new(admin_params)
        @doctor.specialty = "administracion"
        @doctor.area_id = @area[0].id
        @doctor.mail = params[:mail]
        @doctor.user_id = params[:user_id]

        if @doctor.save!(:validate => false) 
            redirect_to '/perfilB', notice: "Los datos del perfil fueron guardados satisfactoriamente."
        else
            redirect_to '/perfilB', alert: "Los datos del perfil no pudieron ser guardados."
        end

    end

    def update_perfil_B
        @doctor = Doctor.find(params[:id])

        if @doctor.update(admin_params)
            redirect_to '/perfilB', notice: "Los datos del perfil fueron actualizados satisfactoriamente."
        else
            redirect_to '/perfilB', alert: "Los datos del perfil no pudieron ser actualizados."
        end
    end

    #perfil direccion
    def index_perfil_A
        @user = User.find(current_user.id)
        render :perfil_principal
    end

    def save_perfil_A
        
        @area = Area.where("name = ?", "Administración")
        @doctor = Doctor.new(admin_params)
        @doctor.specialty = "administracion"
        @doctor.area_id = @area[0].id
        @doctor.mail = params[:mail]
        @doctor.user_id = params[:user_id]

        if @doctor.save!(:validate => false) 
            redirect_to '/perfilA', notice: "Los datos del perfil fueron guardados satisfactoriamente."
        else
            redirect_to '/perfilA', alert: "Los datos del perfil no pudieron ser guardados."
        end


    end

    def update_perfil_A
        @doctor = Doctor.find(params[:id])

        if @doctor.update(admin_params)
            redirect_to '/perfilA', notice: "Los datos del perfil fueron actualizados satisfactoriamente."
        else
            redirect_to '/perfilA', alert: "Los datos del perfil no pudieron ser actualizados."
        end
    end

    #Percil Convenio
    def index_perfil_C
        @user = User.find(current_user.id)
        render :perfil_convenio
    end

    def save_perfil_C

        @area = Area.where("name = ?", "Administración")
        @doctor = Doctor.new(admin_params)
        @doctor.specialty = "administracion"
        @doctor.area_id = @area[0].id
        @doctor.mail = params[:mail]
        @doctor.user_id = params[:user_id]

        if @doctor.save!(:validate => false) 
            redirect_to '/perfilC', notice: "Los datos del perfil fueron guardados satisfactoriamente."
        else
            redirect_to '/perfilC', alert: "Los datos del perfil no pudieron ser guardados."
        end
    end

    def update_perfil_C
        @doctor = Doctor.find(params[:id])

        if @doctor.update(admin_params)
            redirect_to '/perfilC', notice: "Los datos del perfil fueron actualizados satisfactoriamente."
        else
            redirect_to '/perfilC', alert: "Los datos del perfil no pudieron ser actualizados."
        end
    end

    private
    def admin_params
      params.permit(:name, :middle_name, :last_name, :surname, :document, :phone, :gender, :specialty, :mail, :birthday, :status, :address, :area_id, :firm )
    end

end
