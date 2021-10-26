class DoctorsController < ApplicationController

    def index
        @user = User.find(current_user.id)
    end

    def save

        @doctor = Doctor.new(doctor_params)
        @doctor.user_id = current_user.id
        @doctor.mail = current_user.email

        if @doctor.save 
            redirect_to '/perfilM', notice: "Datos de perfil actualizados correctamente."
        else
            redirect_to '/perfilM', alert: "Los datos de perfil no pudieron ser guardados."
        end

    end

    def update 

        @doctor = Doctor.find(params[:id])

        if @doctor.update(doctor_params)
            redirect_to '/perfilM', notice: "Datos de perfil actualizados correctamente."
        else
            redirect_to '/perfilM', alert: "Los datos de perfil no pudieron ser actualizados."
        end
    
    end

    def upload_image 
        
        @doctor = Doctor.find(current_user.doctor.id)
        
        render 'doctors/upload_firm'
    end

    def update_with_image 
        
        @doctor = Doctor.find(params[:id])

        #@doctor.firm = Base64.encode64 (params[:firm].path)
        @doctor.firm = params[:firm]

        if @doctor.update(doctor_params)
            redirect_to '/upload_image', notice: "Su firma fue agregada satisfactoriamente."
        else
            redirect_to '/upload_image', alert: "Su firma no pudo ser agregada."
        end

    end

    def doctors_created
        @doctors = Doctor.where("status = 'Activo' or status = 'Masivo'")

        render :list_to_add_firm
    end

    def add_firm_by_principal
        
        @doctor =  Doctor.find(params[:id])

        render :add_firm

    end

    def update_with_firm
        
        @doctor = Doctor.find(params[:id])

        #@doctor.firm = Base64.encode64 (params[:firm].path)
        #@doctor.firm = params[:firm]
        
        if @doctor.update_attribute :firm, params[:firm]
            redirect_to '/admin-doctors', notice: "La firma pudo ser asociada al médico de manera exitosa."
        else
            redirect_to '/admin-doctors', alert: "No fue posible agregar firma al médico."
        end

    end
    
    def create_doctor

        @users = User.where ("status = 'Activo' and user_type = 'Medico' and busy = 'Disponible' ")
        render :create_doctor
    end

    def save_doctor
        
        @user = User.new(user_type: "Medico", email: params[:email], password:"medi-chat123", status: "Activo", busy: "Ocupado")

        if User.exists?(email: params[:email])
            
            redirect_to '/admin-doctors', alert: "Cambie el correo del médico y verifique sus datos."
        else

            if @user.save!(:validate => false)
            
                @doctor = Doctor.new(doctor_params)
                @doctor.status = "Activo"
                @doctor.user = @user
    
                if @doctor.save
                    redirect_to '/admin-doctors', notice: "El médico fue creado exitosamente."
                else
                    redirect_to '/admin-doctors', alert: "No se pudo crear al nuevo médico."
                end
    
            else
                redirect_to '/admin-doctors', alert: "No se pudo crear al nuevo médico, imposible utilizar el correo asignado."
            end
            
        end

    end

    private
    def doctor_params
      params.permit(:name, :middle_name, :last_name, :surname, :document, :phone, :gender, :specialty, :mail, :birthday, :status, :address, :area_id, :firm, :ficha, :rif, :sanidad, :code_doctor )
    end
    
end
