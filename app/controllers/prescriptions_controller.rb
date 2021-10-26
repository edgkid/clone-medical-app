class PrescriptionsController < ApplicationController

    def create
        render :prescription
    end  

    def save
        case_number = 1
        date = Date.today.strftime("%d-%m-%y")
        @appointment = Appointment.where("to_char(created_at, 'dd-MM-yy') = ? AND patient_id = ? AND doctor_id = ?", date, params[:patient_id], params[:doctor_id]).order(created_at: :desc)
        
        if @appointment.length > 0

            #@appointment = Appointment.where("to_char(created_at, 'dd-MM-yy') = ? AND patient_id = ? AND doctor_id = ?", date, params[:patient_id], params[:doctor_id]).order(created_at: :desc)

            @prescription = Prescription.new(use: params[:use], medicine: params[:medicine], appointment_id: @appointment[0].id)
            if  @prescription.save(:validate => false)
                redirect_to '/messages/' + params[:doctor_id] +'/doctor', notice: "Infomración de récipe guardado con exito"
            else
                redirect_to '/messages/' + params[:doctor_id] + '/doctor', notice: "La informacón de récipe no pudo ser guardada"
            end

        else
            
            if Appointment.maximum(:case_number) != nil

                case_number =  Appointment.maximum(:case_number) + 1
            end

            @appointment = Appointment.new(patient_id: params[:patient_id], doctor_id: params[:doctor_id], case_number: case_number)
            if @appointment.save!(:validate => false)
                
                @prescription = Prescription.new(use: params[:use], medicine: params[:medicine], appointment: @appointment)
                if @prescription.save!(:validate => false )
                    redirect_to '/messages/' + params[:doctor_id] +'/doctor', notice: "Infomración de historia guardada con exito"
                else
                    redirect_to '/messages/' + params[:doctor_id] + '/doctor', notice: "La informacón de historia no pudo ser guarda"
                end
            else
                redirect_to '/messages/' + params[:doctor_id] + '/doctor', alert: "La informacón de historia no pudo ser guarda"
            end
        end
        
    end
    
    def update

        @prescription = Prescription.find(params[:id])

        if @prescription.update(prescription_params)
            redirect_to '/messages/' + params[:doctor_id] + '/doctor', notice: "La informacón de recipe no pudo ser actualizada"
        else
            redirect_to '/messages/' + params[:doctor_id] + '/doctor', alert: "La informacón de recipe no pudo ser actualizada"
        end

    end 

    def save_from_call
        case_number = 1
        date = Date.today.strftime("%d-%m-%y")
        @appointment = Appointment.where("to_char(created_at, 'dd-MM-yy') = ? AND patient_id = ? AND doctor_id = ?", date, params[:patient_id], params[:doctor_id]).order(created_at: :desc)
        
        if @appointment.length > 0

            #@appointment = Appointment.where("to_char(created_at, 'dd-MM-yy') = ? AND patient_id = ? AND doctor_id = ?", date, params[:patient_id], params[:doctor_id]).order(created_at: :desc)

            @prescription = Prescription.new(use: params[:use], medicine: params[:medicine], appointment_id: @appointment[0].id)
            if  @prescription.save(:validate => false)
                redirect_to '/appointment-by-phone/' + params[:doctor_id].to_s + "/" + params[:patient_id].to_s + "/" + params[:patient_plan_id].to_s, notice: "Infomración de récipe guardado con exito"
            else
                redirect_to '/appointment-by-phone/' + params[:doctor_id].to_s + "/" + params[:patient_id].to_s + "/" + params[:patient_plan_id].to_s, notice: "La informacón de récipe no pudo ser guardada"
            end

        else
            
            if Appointment.maximum(:case_number) != nil

                case_number =  Appointment.maximum(:case_number) + 1
            end

            @appointment = Appointment.new(patient_id: params[:patient_id], doctor_id: params[:doctor_id], case_number: case_number)
            if @appointment.save!(:validate => false)
                
                @prescription = Prescription.new(use: params[:use], medicine: params[:medicine], appointment: @appointment)
                if @prescription.save!(:validate => false )
                    redirect_to '/appointment-by-phone/' + params[:doctor_id].to_s + "/" + params[:patient_id].to_s + "/" + params[:patient_plan_id].to_s, notice: "Infomración de historia guardada con exito"
                else
                    redirect_to '/appointment-by-phone/' + params[:doctor_id].to_s + "/" + params[:patient_id].to_s + "/" + params[:patient_plan_id].to_s, notice: "La informacón de historia no pudo ser guarda"
                end
            else
                redirect_to '/appointment-by-phone/' + params[:doctor_id].to_s + "/" + params[:patient_id].to_s + "/" + params[:patient_plan_id].to_s, alert: "La informacón de historia no pudo ser guarda"
            end
        end
        
    end
    
    def update_from_call

        @prescription = Prescription.find(params[:id])

        if @prescription.update(prescription_params)
            redirect_to '/appointment-by-phone/' + params[:doctor_id].to_s + "/" + params[:patient_id].to_s + "/" + params[:patient_plan_id].to_s, notice: "La informacón de recipe no pudo ser actualizada"
        else
            redirect_to '/appointment-by-phone/' + params[:doctor_id].to_s + "/" + params[:patient_id].to_s + "/" + params[:patient_plan_id].to_s, alert: "La informacón de recipe no pudo ser actualizada"
        end

    end 

    def print
        @appointment = Appointment.find(params[:id])

        @prescription = Prescription.find(@appointment.prescription.id )
        respond_to do |format|
            format.html
            format.pdf{render template: 'documents/recipe', :orientation => 'Landscape', pdf: 'Recipe'}
        end
    end

    private
    def prescription_params
      params.permit(:medicine, :use)
    end

end
