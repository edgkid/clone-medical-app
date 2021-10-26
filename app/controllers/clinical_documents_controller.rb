class ClinicalDocumentsController < ApplicationController

    def print

        @appointment = Appointment.find(params[:id])
        @para_clinical = ClinicalDocument.where("appointment_id = ?", @appointment.id )

        respond_to do |format|
            format.html
            format.pdf{render template: 'documents/para_clinico', pdf: 'Para-Clinico'}
        end
    
    end

    def save
        case_number = 0
        date = Date.today.strftime("%d-%m-%y")
        #@appointment = Appointment.where("to_char(created_at, 'dd-MM-yy') = ?", date)
        @appointment = Appointment.where("to_char(created_at, 'dd-MM-yy') = ? AND patient_id = ? AND doctor_id = ?", date, params[:patient_id], params[:doctor_id]).order(created_at: :desc)

        if @appointment.length > 0
            #@appointment = Appointment.where("to_char(created_at, 'dd-MM-yy') = ? AND patient_id = ? AND doctor_id = ?", date, params[:patient_id], params[:doctor_id]).order(created_at: :desc)
            
            @clinical_document = ClinicalDocument.new(info: params[:info], appointment_id: @appointment[0].id)
            if  @clinical_document.save(:validate => false)
                redirect_to '/messages/' + params[:doctor_id] + '/doctor', notice: "La informacón del paraclínico fue guardada con exito"
            else
                redirect_to '/messages/' + params[:doctor_id] + '/doctor', alert: "La informacón del paraclínico fue guardada con exito"
            end
        else

            if Appointment.maximum(:case_number) != nil

                case_number =  Appointment.maximum(:case_number) + 1
            end

            @appointment = Appointment.new(patient_id: params[:patient_id], doctor_id: params[:doctor_id], case_number: case_number)
            if @appointment.save!(:validate => false)
                
                @clinical_document = ClinicalDocument.new(info: params[:info], appointment: @appointment)
                if @clinical_document.save(:validate => false)
                    redirect_to '/messages/' + params[:doctor_id] + '/doctor', notice: "La informacón del paraclínico fue guardada con exito"
                else
                    redirect_to '/messages/' + params[:doctor_id] + '/doctor', alert: "La informacón del paraclínico no pudo ser guarda"
                end 
            else
                redirect_to '/messages/' + params[:doctor_id] + '/doctor', alert: "La informacón del paraclínico no pudo ser guarda"
            end

        end
    end

    def update
        
        @document_clinical = ClinicalDocument.find(params[:id])

        if @document_clinical.update(clinical_document_params)
            redirect_to '/messages/' + params[:doctor_id] + '/doctor', notice: "La informacón del paraclínico fue actualizada con exito"
        else
            redirect_to '/messages/' + params[:doctor_id] + '/doctor', alert: "La informacón del paraclínico no pudo ser actualizada"
        end


    end
    
    def save_from_call
        case_number = 0
        date = Date.today.strftime("%d-%m-%y")
        #@appointment = Appointment.where("to_char(created_at, 'dd-MM-yy') = ?", date)
        @appointment = Appointment.where("to_char(created_at, 'dd-MM-yy') = ? AND patient_id = ? AND doctor_id = ?", date, params[:patient_id], params[:doctor_id]).order(created_at: :desc)

        if @appointment.length > 0
            #@appointment = Appointment.where("to_char(created_at, 'dd-MM-yy') = ? AND patient_id = ? AND doctor_id = ?", date, params[:patient_id], params[:doctor_id]).order(created_at: :desc)
            
            @clinical_document = ClinicalDocument.new(info: params[:info], appointment_id: @appointment[0].id)
            if  @clinical_document.save(:validate => false)
                redirect_to '/appointment-by-phone/' + params[:doctor_id].to_s + "/" + params[:patient_id].to_s + "/" + params[:patient_plan_id].to_s, notice: "La informacón del paraclínico fue guardada con exito"
            else
                redirect_to '/appointment-by-phone/' + params[:doctor_id].to_s + "/" + params[:patient_id].to_s + "/" + params[:patient_plan_id].to_s, alert: "La informacón del paraclínico fue guardada con exito"
            end
        else

            if Appointment.maximum(:case_number) != nil

                case_number =  Appointment.maximum(:case_number) + 1
            end

            @appointment = Appointment.new(patient_id: params[:patient_id], doctor_id: params[:doctor_id], case_number: case_number)
            if @appointment.save!(:validate => false)
                
                @clinical_document = ClinicalDocument.new(info: params[:info], appointment: @appointment)
                if @clinical_document.save(:validate => false)
                    redirect_to '/appointment-by-phone/' + params[:doctor_id].to_s + "/" + params[:patient_id].to_s + "/" + params[:patient_plan_id].to_s, notice: "La informacón del paraclínico fue guardada con exito"
                else
                    redirect_to '/appointment-by-phone/' + params[:doctor_id].to_s + "/" + params[:patient_id].to_s + "/" + params[:patient_plan_id].to_s, alert: "La informacón del paraclínico no pudo ser guarda"
                end 
            else
                redirect_to '/appointment-by-phone/' + params[:doctor_id].to_s + "/" + params[:patient_id].to_s + "/" + params[:patient_plan_id].to_s, alert: "La informacón del paraclínico no pudo ser guarda"
            end

        end
    end

    def update_from_call
        
        @document_clinical = ClinicalDocument.find(params[:id])

        if @document_clinical.update(clinical_document_params)
            redirect_to '/appointment-by-phone/' + params[:doctor_id].to_s + "/" + params[:patient_id].to_s + "/" + params[:patient_plan_id].to_s, notice: "La informacón del paraclínico fue actualizada con exito"
        else
            redirect_to '/appointment-by-phone/' + params[:doctor_id].to_s + "/" + params[:patient_id].to_s + "/" + params[:patient_plan_id].to_s, alert: "La informacón del paraclínico no pudo ser actualizada"
        end


    end
    private
    def clinical_document_params
      params.permit(:info)
    end

end
