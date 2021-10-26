class Appointment < ApplicationRecord

    belongs_to :doctor
    belongs_to :patient

    has_one :report

    has_one :prescription

    has_one :clinical_document

    has_many :active_appointments
    has_many :patient_plans, through: :active_appointments

    scope :by_doctor, -> (doctor_id) { where(doctor_id: doctor_id) }

    def patient_per_diagnostic_by_doctor(doctor_id) 

        @object = {a: 4, b: 6, c: 10, d:2, e:34, f:20, g:10}
    
        return @object
        
    end

    def get_appointments (params)

        have_ini_value = false
        have_end_value = false
        date = Date.today
        @appointments = Appointment.where("created_at >= ?", date.year.to_s + "-" + date.month.to_s + "-01"  )

        if params[:ini] != "" && params[:ini] != nil
            have_ini_value = true
        end

        if params[:end] != "" && params[:ini] != nil
            have_end_value = true
        end
        
        if have_ini_value == true && have_end_value == true
            @appointments = Appointment.where("created_at >= ? AND created_at <= ?", params[:ini] , params[:end] )
        else
            if have_ini_value == true
                @appointments = Appointment.where("created_at >= ?", params[:ini] )
            end
            if have_end_value == true
                @appointments = Appointment.where("created_at <= ?", params[:end] )
            end
        end

        return @appointments
    end

    def get_appointments_by_doctors (params)

        have_ini_value = false
        have_end_value = false
        date = Date.today
        @appointments = Appointment.where("doctor_id = ? AND created_at >= ?", params[:doctor], date.year.to_s + "-" + date.month.to_s + "-01"  )

        if params[:ini] != "" && params[:ini] != nil
            have_ini_value = true
        end

        if params[:end] != "" && params[:ini] != nil
            have_end_value = true
        end
        
        if have_ini_value == true && have_end_value == true
            @appointments = Appointment.where("doctor_id = ? AND created_at >= ? AND created_at <= ?", params[:doctor], params[:ini] , params[:end] )
        else
            if have_ini_value == true
                @appointments = Appointment.where("doctor_id = ? AND created_at >= ?", params[:doctor], params[:ini] )
            end
            if have_end_value == true
                @appointments = Appointment.where("doctor_id = ? AND created_at <= ?", params[:doctor], params[:end] )
            end
        end

        return @appointments
    end

    def get_appointments_by_patients (params)

        have_ini_value = false
        have_end_value = false
        date = Date.today
        @appointments = Appointment.where("patient_id = ? AND created_at >= ?", params[:patient], date.year.to_s + "-" + date.month.to_s + "-01"  )

        if params[:ini] != "" && params[:ini] != nil
            have_ini_value = true
        end

        if params[:end] != "" && params[:ini] != nil
            have_end_value = true
        end
        
        if have_ini_value == true && have_end_value == true
            @appointments = Appointment.where("patient_id = ? AND created_at >= ? AND created_at <= ?", params[:patient], params[:ini] , params[:end] )
        else
            if have_ini_value == true
                @appointments = Appointment.where("patient_id = ? AND created_at >= ?", params[:patient], params[:ini] )
            end
            if have_end_value == true
                @appointments = Appointment.where("patient_id = ? AND created_at <= ?", params[:patient], params[:end] )
            end
        end

        return @appointments
    end

    def get_appointments_by_areas(params)
    
        @appointments = nil
        have_ini_value = false
        have_end_value = false
        have_area = false
        date = Date.today

        if params[:ini] != "" && params[:ini] != nil
            have_ini_value = true
        end
        if params[:end] != "" && params[:ini] != nil
            have_end_value = true
        end
        if params[:area] != "" && params[:area] != nil
            have_area = true
        end

        if have_ini_value || have_end_value
            if have_ini_value && have_end_value && have_area
                @appointments = Appointment.joins(:doctor).where("appointments.created_at >= ? AND created_at <= ? AND doctors.area_id = ?", params[:ini] , params[:end], params[:area] )
            elsif have_ini_value && have_area
                @appointments = Appointment.joins(:doctor).where("appointments.created_at >= ? AND doctors.area_id = ?", params[:ini] , params[:area] )
            elsif have_end_value && have_area
                @appointments = Appointment.joins(:doctor).where("appointments.created_at <= ? AND doctors.area_id = ?", params[:end] , params[:area] )
            elsif have_ini_value && have_end_value
                @appointments = Appointment.where("created_at >= ? AND created_at <= ?", params[:ini] , params[:end] )
            elsif have_ini_value
                @appointments = Appointment.where("created_at >= ?", params[:ini])
            elsif have_end_value
                @appointments = Appointment.where("created_at <= ?", params[:end] )
            end 
        else
            if have_area
                @appointments = Appointment.joins(:doctor).where("doctors.area_id = ?", params[:area] )
            end
        end

        if have_ini_value == false && have_end_value == false && have_area == false
            @appointments = Appointment.where("created_at >= ?", date.year.to_s + "-" + date.month.to_s + "-01").distinct
        end

        return @appointments
    
    end

    def get_appointments_by_diagnostic(params)

        @appointments = nil
        have_ini_value = false
        have_end_value = false
        have_diagnostic_code = false
        date = Date.today

        if params[:ini] != "" && params[:ini] != nil
            have_ini_value = true
        end
        if params[:end] != "" && params[:ini] != nil
            have_end_value = true
        end
        if params[:diagnostic_code] != "" && params[:diagnostic_code] != nil
            have_diagnostic_code = true
        end

        if have_ini_value || have_end_value

            if have_ini_value && have_end_value && have_diagnostic_code
            elsif have_ini_value && have_diagnostic_code
                @appointments = Diagnostic.where("diagnostics.created_at >= ? AND diagnostics.created_at <= ? AND diagnostics.code LIKE ?", params[:ini], params[:end], "%#{params[:diagnostic_code]}%" ).distinct
            elsif have_end_value && have_diagnostic_code
                @appointments = Diagnostic.where("diagnostics.created_at <= ? AND diagnostics.code LIKE ?", params[:end], "%#{params[:diagnostic_code]}%" ).distinct
            elsif have_ini_value && have_end_value
                @appointments = Diagnostic.where("diagnostics.created_at >= ? AND created_at <= ?", params[:ini] , params[:end] ).distinct
            elsif have_ini_value
                @appointments = Diagnostic.where("diagnostics.created_at >= ?", params[:ini]).distinct
            elsif have_end_value
                @appointments = Diagnostic.where("diagnostics.created_at <= ?", params[:end] ).distinct
            end

        else
            if have_diagnostic_code
                @appointments = Diagnostic.where("diagnostics.code = ?", params[:diagnostic_code] ).distinct
            end
        end

        if have_ini_value == false && have_end_value == false && have_diagnostic_code == false
            @appointments = Diagnostic.where("diagnostics.created_at >= ?", date.year.to_s + "-" + date.month.to_s + "-01").distinct
        end

        return @appointments

    end

end
