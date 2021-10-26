class ReportsController < ApplicationController

    def create
        
        render :report
    end  

    def save

        case_number = 1
        date = Date.today.strftime("%d-%m-%y")
        #@appointment = Appointment.where("to_char(created_at, 'dd-MM-yy') = ?", date)
        @appointment = Appointment.where("to_char(created_at, 'dd-MM-yy') = ? AND patient_id = ? AND doctor_id = ?", date, params[:patient_id], params[:doctor_id]).order(created_at: :desc)

        @diagnostic = Diagnostic.new()
        diagnostics = @diagnostic.get_diagnostic_ref(params[:diagnostic])
        
        if @appointment.length > 0
            #puts "Asigno cita"
            #@appointment = Appointment.where("to_char(created_at, 'dd-MM-yy') = ? AND patient_id = ? AND doctor_id = ?", date, params[:patient_id], params[:doctor_id]).order(created_at: :desc)

            @report = Report.new(reason: params[:reason], disease: params[:disease], past: params[:past], exam: params[:exam], diagnostic: @appointment, prescription_des: params[:prescription_des], medicine:params[:medicine] , use: params[:use], appointment_id: @appointment[0].id)
            if  @report.save(:validate => false)
                @diagnostic.save_diagnostic_by_appointment({report: @report, diagnostics: params[:diagnostic] })
                redirect_to '/messages/' + params[:doctor_id] +'/doctor', notice: "Infomración de historia guardada con exito"
            else
                redirect_to '/messages/' + params[:doctor_id] + '/doctor', notice: "La informacón de historia no pudo ser guardada"
            end
        else
            #puts "Creo cita"
            if Appointment.maximum(:case_number) != nil

                case_number =  Appointment.maximum(:case_number) + 1
            end
            @appointment = Appointment.new(patient_id: params[:patient_id], doctor_id: params[:doctor_id], case_number: case_number)
            if @appointment.save!(:validate => false)
                @report = Report.new(reason: params[:reason], disease: params[:disease], past: params[:past], exam: params[:exam], diagnostic: @appointment, prescription_des: params[:prescription_des], medicine:params[:medicine] , use: params[:use], appointment: @appointment)
                
                if @report.save!(:validate => false )
                    @diagnostic.save_diagnostic_by_appointment({report: @report, diagnostics: params[:diagnostic] })
                    redirect_to '/messages/' + params[:doctor_id] +'/doctor', notice: "Infomración de historia guardada con exito"
                else
                    redirect_to '/messages/' + params[:doctor_id] + '/doctor', notice: "La informacón de historia no pudo ser guarda"
                end
            else
                redirect_to '/messages/' + params[:doctor_id] + '/doctor', notice: "La informacón de historia no pudo ser guarda"
            end

        end
        
    end 

    def update

        @report = Report.find(params[:id])
        @diagnostic = Diagnostic.new()
        diagnostics = @diagnostic.get_diagnostic_ref(params[:diagnostic])

        @report.diagnostics.destroy_all

        if @report.update(report_params)
            @diagnostic.save_diagnostic_by_appointment({report: @report, diagnostics: params[:diagnostic] })
            redirect_to '/messages/' + params[:doctor_id] +'/doctor', notice: "Infomración de historia guardada con exito"
        else
            redirect_to '/messages/' + params[:doctor_id] + '/doctor', notice: "La informacón de historia no pudo ser guarda"
            
        end
    
    end

    def save_from_call

        case_number = 1
        date = Date.today.strftime("%d-%m-%y")
        @appointment = Appointment.where("to_char(created_at, 'dd-MM-yy') = ? AND patient_id = ? AND doctor_id = ?", date, params[:patient_id], params[:doctor_id]).order(created_at: :desc)

        @diagnostic = Diagnostic.new()
        diagnostics = @diagnostic.get_diagnostic_ref(params[:diagnostic])
        
        if @appointment.length > 0

            @report = Report.new(reason: params[:reason], disease: params[:disease], past: params[:past], exam: params[:exam], diagnostic: @appointment, prescription_des: params[:prescription_des], medicine:params[:medicine] , use: params[:use], appointment_id: @appointment[0].id)
            if  @report.save(:validate => false)
                @diagnostic.save_diagnostic_by_appointment({report: @report, diagnostics: params[:diagnostic] })
                redirect_to '/appointment-by-phone/' + params[:doctor_id].to_s + "/" + params[:patient_id].to_s + "/" + params[:patient_plan_id].to_s, notice: "Infomración de historia guardada con exito"
            else
                redirect_to '/appointment-by-phone/' + params[:doctor_id].to_s + "/" + params[:patient_id].to_s + "/" + params[:patient_plan_id].to_s, notice: "La informacón de historia no pudo ser guardada"
            end
        else

            if Appointment.maximum(:case_number) != nil

                case_number =  Appointment.maximum(:case_number) + 1
            end
            @appointment = Appointment.new(patient_id: params[:patient_id], doctor_id: params[:doctor_id], case_number: case_number)
            if @appointment.save!(:validate => false)
                @report = Report.new(reason: params[:reason], disease: params[:disease], past: params[:past], exam: params[:exam], diagnostic: @appointment, prescription_des: params[:prescription_des], medicine:params[:medicine] , use: params[:use], appointment: @appointment)
                
                if @report.save!(:validate => false )
                    @diagnostic.save_diagnostic_by_appointment({report: @report, diagnostics: params[:diagnostic] })
                    redirect_to '/appointment-by-phone/' + params[:doctor_id].to_s + "/" + params[:patient_id].to_s + "/" + params[:patient_plan_id].to_s , notice: "Infomración de historia guardada con exito"
                else
                    redirect_to '/appointment-by-phone/' + params[:doctor_id].to_s + "/" + params[:patient_id].to_s + "/" + params[:patient_plan_id].to_s, notice: "La informacón de historia no pudo ser guarda"
                end
            else
                redirect_to '/appointment-by-phone/' + params[:doctor_id].to_s + "/" + params[:patient_id].to_s + "/" + params[:patient_plan_id].to_s, notice: "La informacón de historia no pudo ser guarda"
            end

        end
        
    end 

    def update_from_call

        @report = Report.find(params[:id])
        @diagnostic = Diagnostic.new()
        diagnostics = @diagnostic.get_diagnostic_ref(params[:diagnostic])

        @report.diagnostics.destroy_all

        if @report.update(report_params)
            @diagnostic.save_diagnostic_by_appointment({report: @report, diagnostics: params[:diagnostic] })
            redirect_to '/appointment-by-phone/' + params[:doctor_id].to_s + "/" + params[:patient_id].to_s + "/" + params[:patient_plan_id].to_s, notice: "Infomración de historia guardada con exito"
        else
            redirect_to '/appointment-by-phone/' + params[:doctor_id].to_s + "/" + params[:patient_id].to_s + "/" + params[:patient_plan_id].to_s, notice: "La informacón de historia no pudo ser guarda"
            
        end
    
    end
    

    def print
        @appointment = Appointment.find(params[:id])
        @report = Report.find(@appointment.report.id )
        respond_to do |format|
            format.html
            format.pdf{render template: 'documents/historia_medica', pdf: 'Historia médica'}
        end
    end

    def print_report_prescription
        #@report= Prescription.new(report_params)
        respond_to do |format|
            format.html
            format.pdf{render template: 'documents/historia_recipe', pdf: 'Historia y récipe'}
        end
    end

    private
    def report_params
      params.permit(:reason, :disease, :past, :exam, :diagnostic, :prescription_des, :medicine, :use)
    end
end
