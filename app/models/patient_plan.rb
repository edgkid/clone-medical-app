class PatientPlan < ApplicationRecord

    belongs_to :patient
    belongs_to :plan

    has_many :active_appointments
    has_many :appointments, through: :active_appointments


    def get_actual_patient_plans (id)

        @insurance_plan = PatientPlan.where("patient_id = ? AND type_plan = ?", id, "De Seguro").order('id DESC')
        @particular_plan = PatientPlan.where("patient_id = ? AND type_plan = ?", id, "Particular").order('id DESC').limit(1)
        

        if (@insurance_plan.length != 0 && @particular_plan.length  != 0)
            @patient_plan = PatientPlan.where("id in (?,?)",  @insurance_plan[0].id,@particular_plan[0].id).order('id ASC')
        end

        if (@insurance_plan.length != 0 && @particular_plan.length  == 0)
            @patient_plan = PatientPlan.where("id = ?",  @insurance_plan[0].id).order('id ASC')
        end

        if (@insurance_plan.length == 0 && @particular_plan.length  != 0)
            @patient_plan = PatientPlan.where("id = ?",  @particular_plan[0].id).order('id ASC')
        end


        return @patient_plan
    end

end
