class BoardsController < ApplicationController

    def index_patient_board

        @patient_plan  = nil
        @appointment = nil
        @user = User.find(current_user.id)
        @offers = Offer.where("status = ?", "Activo")

        if @user.patient
            patient_plan_date = PatientPlan.where("patient_id = ?", @user.patient.id).maximum(:created_at)
            @patient_plan = PatientPlan.where("created_at = ? ", patient_plan_date)

            appointment_date = Appointment.where("patient_id = ?", @user.patient.id).maximum(:created_at)
            @appointment = Appointment.where("created_at = ? ", appointment_date)
        end
       
        

        render :board_patient
    end

    def index_doctor_board

        @patient = Patient.new()
        @appointment = Appointment.new()
        @user = User.find(current_user.id)
        @doctor = Doctor.where("user_id = ?", @user.id)
        
        #@doctor_appointments = Appointment.where("doctor_id  = ?", @doctor[0].id)
        if @doctor.length > 0

            @doctor_appointments = @appointment.get_appointments_by_doctors({ini: params[:ini_date], end: params[:end_date], doctor: @doctor[0].id})
            @totalPatients = @patient.total_patient_particular_vs_insured_by_doctor({ini: params[:ini_date], end: params[:end_date], doctor: @doctor[0].id})
        
        else
            @doctor_appointments = nil
            @totalPatients = nil
        end
        
        

        render :board_doctor
    end

    def index_root_board 

        @patient = Patient.new()
        @appointment = Appointment.new()
        @insurance = Insurance.new()

        @user = User.find(current_user.id)
        @doctor = Doctor.where("user_id = ?", @user.id)
        
        @doctor_appointments = @appointment.get_appointments({ini: params[:ini_date], end: params[:end_date]})
        @totalPatients = @patient.total_patient_particular_vs_insured ({ini: params[:ini_date], end: params[:end_date]})

        @appointments = @appointment.get_appointments_by_areas({ini: params[:ini_date], end: params[:end_date], area: params[:area]})
        @areas = Area.where("status ='Activo' and (areas.name != 'Administración' or areas.name != 'Administracion')")
        @patients_per_areas = @patient.total_patient_per_speciality({areas: @areas, appointments: @appointments})

        @diagnostics = @appointment.get_appointments_by_diagnostic({ini: params[:ini_date], end: params[:end_date], diagnostic_code: params[:diagnostic_code]})
        @patient_per_diagnostic = @patient.total_patient_per_diagnostic({diagnostics: @diagnostics})

        @insurances = @insurance.get_insurances({ini: params[:ini_date], end: params[:end_date], company: params[:company], insurance: params[:insurance]})
        @patients_by_insurance = @patient.total_patient_per_insurance({insurances: @insurances})

        @doctors = @patient.get_doctors_by_date({ini: params[:ini_date], end: params[:end_date]})
        @list_doctors = Doctor.where("id in (" + @doctors + ")")
        @patients_by_doctors = @patient.total_patient_per_doctor(@list_doctors)

        @plans = Plan.where("status = ? OR (created_at >= ? OR created_at <= ?)", "Activo", params[:ini] , params[:end] )
        @patients = Patient.where("status = ? OR (created_at >= ? OR created_at <= ?)", "Masivo", params[:ini] , params[:end] )

        render :board_root
    end

    def index_convenio

        @patient = Patient.new()
        @appointment = Appointment.new()

        @plans = Plan.where("status = ? OR (created_at >= ? OR created_at <= ?)", "Activo", params[:ini] , params[:end] )
        @patients = Patient.where("status = ? OR (created_at >= ? OR created_at <= ?)", "Masivo", params[:ini] , params[:end] )

        @doctor_appointments = @appointment.get_appointments({ini: params[:ini_date], end: params[:end_date]})
        @totalPatients = @patient.total_patient_particular_vs_insured ({ini: params[:ini_date], end: params[:end_date]})

        render :board_convenio
    end

    def index_caja
        render :board_caja
    end

    def index_principal_doctor

        @patient = Patient.new()
        @appointment = Appointment.new()
        @insurance = Insurance.new()

        @user = User.find(current_user.id)
        @doctor = Doctor.where("user_id = ?", @user.id)
        
        @doctor_appointments = @appointment.get_appointments({ini: params[:ini_date], end: params[:end_date]})
        @totalPatients = @patient.total_patient_particular_vs_insured ({ini: params[:ini_date], end: params[:end_date]})

        @appointments = @appointment.get_appointments_by_areas({ini: params[:ini_date], end: params[:end_date], area: params[:area]})
        @areas = Area.where("status ='Activo' and (areas.name != 'Administración' or areas.name != 'Administracion')")
        @patients_per_areas = @patient.total_patient_per_speciality({areas: @areas, appointments: @appointments})

        @diagnostics = @appointment.get_appointments_by_diagnostic({ini: params[:ini_date], end: params[:end_date], diagnostic_code: params[:diagnostic_code]})
        @patient_per_diagnostic = @patient.total_patient_per_diagnostic({diagnostics: @diagnostics})

        @insurances = @insurance.get_insurances({ini: params[:ini_date], end: params[:end_date], company: params[:company], insurance: params[:insurance]})
        @patients_by_insurance = @patient.total_patient_per_insurance({insurances: @insurances})

        @doctors = @patient.get_doctors_by_date({ini: params[:ini_date], end: params[:end_date]})
        @list_doctors = Doctor.where("id in (" + @doctors + ")")
        @patients_by_doctors = @patient.total_patient_per_doctor(@list_doctors)

        render :board_principal_doctor
    end

end
