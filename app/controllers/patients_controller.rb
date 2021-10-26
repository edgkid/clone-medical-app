class PatientsController < ApplicationController

    def index
        @user = User.find(current_user.id)
        @insurances = Insurance.all
    end

    def create_patient

        @users = User.where ("status = 'Activo' and user_type = 'Paciente' and busy = 'Disponible'")

        render :new_by_admin
    end

    def save_patient_by_admin 

        @user = User.new(user_type: "Medico", email: params[:email], password:"123456", status: "Activo", busy: "Ocupado")

        if User.exists?(email: params[:email])
            
            redirect_to '/admin-doctors', alert: "Cambie el correo del paciente y verifique sus datos."
        else

            if @user.save!(:validate => false)
            
                @patient = Patient.new(patient_params)
                @patient.user = @user
                @patient.status = "Activo"
    
                if @patient.save
                    redirect_to '/admin-patients', notice: "El paciente fue creado exitosamente."
                else
                    redirect_to '/admin-patients', alert: "No se pudo guardar al nuevo paciente."
                end
    
            else
                redirect_to '/admin-patients', alert: "No se pudo guardar al nuevo paciente."
            end
            
        end
        
        #@patient = Patient.new(patient_params)

        #@patient.user_id = params[:user_id]
        #@patient.status = "Activo"

        #if @patient.save 

            #@user= User.find(params[:user_id])
           # @user.update_attribute :busy, "Ocupado"

          #  redirect_to '/admin-patients', notice: "El paciente fue creado exitosamente."
        #else
         #   redirect_to '/admin-patients', alert: "No se pudo guardar al nuevo paciente."
        #end
    
    end

    def save
        @patient = Patient.new(patient_params)
        @patient.user_id = current_user.id
        @patient.mail = current_user.email

        if @patient.save 
            redirect_to '/perfilP', notice: "Datos de perfil guardados correctamente."
        else
            redirect_to '/perfilP', alert: "Los datos de perfil no pudieron ser guardados."
        end

    end

    def update 

        @patient = Patient.find(params[:id])

        if @patient.update(patient_params)
            redirect_to '/perfilP', notice: "Datos de perfil actualizados correctamente."
        else
            redirect_to '/perfilP', alert: "Los datos de perfil no pudieron ser actualizados."
        end
    
    end

    def patients_created
        @patients = Patient.all

        render :list_patient
    end

    def load_insurance_by_admin
    
        @patient = Patient.find(params[:id])
        @insurances = Insurance.all
        @companies = Company.all
        @plans = Plan.where("status = ? AND type_plan = ?", "Activo", "De Seguro")
        
        render :insurance_by_admin
    end

    def save_insurance_by_admin

        @patient = Patient.find(params[:id])
        

        if @patient.insured_patients.length > 0

            if @patient.validate_insurance_code(params[:code]) && @patient.validate_insurance_company(params[:insurance_id]) && @patient.validate_insurance_company(params[:company_id]) && @patient.validate_insurance_company(params[:plan_id])
                
                @insured_patient = InsuredPatient.find(@patient.insured_patients[0].id)

                if @insured_patient.update_attribute :insurance_id, params[:insurance_id]
                    redirect_to '/admin-patients', notice: "Se logro asignar el seguro de forma satisfactoria."
                else
                    redirect_to '/admin-patients', alert: "No se logro asignar el seguro de forma satisfactoria."
                end

            else
                redirect_to '/admin-patients/asignar-seguro/' + @patient.id.to_s, alert: "Por favor verifique la información del campo."
            end

            
        else

            if @patient.validate_insurance_code(params[:code]) && @patient.validate_insurance_company(params[:insurance_id]) && @patient.validate_insurance_company(params[:company_id]) && @patient.validate_insurance_company(params[:plan_id])

                @insured_patient = InsuredPatient.new(status: "Activo", code: params[:code], insurance_id: params[:insurance_id], patient_id: params[:id],plan_id: params[:plan_id], company_id: params[:company_id])
                if @insured_patient.save!(:validate => false)
                    redirect_to '/admin-patients', notice: "Se logro asignar el seguro de forma satisfactoria."
                else
                    redirect_to '/admin-patients', alert: "No se logro asignar el seguro de forma satisfactoria."
                end

            else
                redirect_to '/admin-patients/asignar-seguro/' + @patient.id.to_s, alert: "Por favor verifique la información del campo."
            end
            
            
        end

    end

    def load_insurance_by_patient 

        @user = User.find(current_user.id)
        @patient = Patient.find(@user.patient.id)
        @insurances = Insurance.all
        
        render :insurance_by_patient
    
    end

    def save_insurance_by_patien 

        @user = User.find(current_user.id)
        @patient = Patient.find(@user.patient.id)

        if @patient.insured_patients.length > 0
            @insured_patient = InsuredPatient.find(@patient.insured_patients[0].id)

            if @insured_patient.update_attribute :insurance_id, params[:insurance_id]
                redirect_to '/indicar-seguro', notice: "Se logro asignar el seguro de forma satisfactoria."
            else
                redirect_to '/indicar-seguro', alert: "No se logro asignar el seguro de forma satisfactoria."
            end
        else
            @insured_patient = InsuredPatient.new(status: "Activo", code: params[:code], insurance_id: params[:insurance_id], patient_id: @patient.id)
            if @insured_patient.save!(:validate => false)
                redirect_to '/indicar-seguro', notice: "Se logro asignar el seguro de forma satisfactoria."
            else
                redirect_to '/indicar-seguro', alert: "No se logro asignar el seguro de forma satisfactoria."
            end
        end
        
    end

    private
    def patient_params
      params.permit(:name, :middle_name, :last_name, :surname, :document, :phone, :gender, :marital_status, :mail, :birthday, :status, :address )
    end
    
end
