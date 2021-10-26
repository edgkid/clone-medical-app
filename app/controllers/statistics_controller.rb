class StatisticsController < ApplicationController
    
    def particular_vs_insurances

        @start_date = params[:ini_date]
        @end_date = params[:end_date]

        @patient = Patient.new()
        @appointment = Appointment.new()

        @doctor_appointments = @appointment.get_appointments({ini: params[:ini_date], end: params[:end_date]})
        @totalPatients = @patient.total_patient_particular_vs_insured ({ini: params[:ini_date], end: params[:end_date]})
    
        render :view_particular_vs_insurances
    end

    def particular_vs_insurances_by_doctor

        @start_date = params[:ini_date]
        @end_date = params[:end_date]

        @patient = Patient.new()
        @appointment = Appointment.new()
        @user = User.find(current_user.id)
        @doctor = Doctor.where("user_id = ?", @user.id)
        
        @appointments = @appointment.get_appointments_by_doctors({ini: params[:ini_date], end: params[:end_date], doctor: @doctor[0].id})

        @totalPatients = @patient.total_patient_particular_vs_insured_by_doctor({ini: params[:ini_date], end: params[:end_date], doctor: @doctor[0].id})

    
        render :view_particular_vs_insurances_by_doctor
    end

    def patient_per_specialty

        @select_areas = Area.where("status = 'Activo' AND name != 'Administración'")
        @start_date = params[:ini_date]
        @end_date = params[:end_date]
        @area = params[:area]

        @patient = Patient.new()
        @appointment = Appointment.new()

        @appointments = @appointment.get_appointments_by_areas({ini: params[:ini_date], end: params[:end_date], area: params[:area]})
        @areas = Area.where("status ='Activo' and (areas.name != 'Administración' or areas.name != 'Administracion')")
        @patients_per_areas = @patient.total_patient_per_speciality({areas: @areas, appointments: @appointments})
        
        #@appointments = @appointment.get_appointments_by_areas({ini: params[:ini_date], end: params[:end_date], area: params[:area]})

        render :view_patient_per_specialty
    end

    def patient_per_doctor

        @start_date = params[:ini_date]
        @end_date = params[:end_date]
        @doctor = params[:doctor]

        @patient = Patient.new()
        @appointment = Appointment.new()

        @doctors = @patient.get_doctors({ini: params[:ini_date], end: params[:end_date], doctor: params[:doctor]})
        @list_doctors_id = @patient.get_list_doctors(@doctors)
        @list_doctors = Doctor.where("id in (" + @list_doctors_id.to_s + ")")
        @patients_by_doctors = @patient.total_patient_per_doctor(@list_doctors)

        #@appointments = @appointment.get_appointments({ini: params[:ini_date], end: params[:end_date]})
        
        render :view_patient_per_doctor
    end

    def patient_per_insurances

        @start_date = params[:ini_date]
        @end_date = params[:end_date]
        @company_param = params[:company]
        @insurance_param = params[:insurance]

        @patient = Patient.new()
        @insurance = Insurance.new()

        @insurances = @insurance.get_insurances({ini: params[:ini_date], end: params[:end_date], company: params[:company], insurance: params[:insurance]})
        @patients_by_insurance = @patient.total_patient_per_insurance({insurances: @insurances})

        render :view_patient_per_insurances
    end

    def patient_per_diagnostic

        @start_date = params[:ini_date]
        @end_date = params[:end_date]
        @code = params[:diagnostic_code]

        @patient = Patient.new()
        @appointment = Appointment.new()

        @diagnostics = @appointment.get_appointments_by_diagnostic({ini: params[:ini_date], end: params[:end_date], diagnostic_code: params[:diagnostic_code]})
        @patient_per_diagnostic = @patient.total_patient_per_diagnostic({diagnostics: @diagnostics})

        render :view_patient_per_diagnostic
    end


    def print

        @patient = Patient.new()
        @appointment = Appointment.new()
        @insurance = Insurance.new()

        respond_to do |format|
            format.html
            case params[:statistc]
                when "1"
                    @doctor_appointments = @appointment.get_appointments({ini: params[:ini_date_print], end: params[:end_date_print]})
                    @totalPatients = @patient.total_patient_particular_vs_insured ({ini: params[:ini_date_print], end: params[:end_date_print]})
                    format.pdf{render template: 'documents/insurances_vs_particulars', pdf: 'Asegurados-vs-Particulares'}
                when "2"
                    @appointments = @appointment.get_appointments_by_areas({ini: params[:ini_date_print], end: params[:end_date_print], area: params[:area_print]})
                    format.pdf{render template: 'documents/patients_per_areas', pdf: 'Pacientes-por-Areas'}
                when "3"
                    @doctors = @patient.get_doctors({ini: params[:ini_date_print], end: params[:end_date_print], doctor: params[:doctor_print]})
                    format.pdf{render template: 'documents/patients_per_doctors', pdf: 'Pacientes-por-Medicos'}
                when "4"
                    @diagnostics = @appointment.get_appointments_by_diagnostic({ini: params[:ini_date_print], end: params[:end_date_print], diagnostic_code: params[:diagnostic_code_print]})
                    format.pdf{render template: 'documents/patients_per_diagnostics', pdf: 'Pacientes-por-diagnosticos'}
                when "5"
                    @insurances = @insurance.get_insurances({ini: params[:ini_date], end: params[:end_date], company: params[:company], insurance: params[:insurance]})
                    format.pdf{render template: 'documents/patients_per_insurances', pdf: 'Pacientes-por-seguros'}
                else
                puts "No hay estadistica para imprimir"
            end
        end
    end

end
