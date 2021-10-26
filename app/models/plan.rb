class Plan < ApplicationRecord

    validates :name, :total_appointments,:cost, presence: true

    validates :name, length: { maximum: 30,  message: "Solo se permiten 30 caracteres" }
    validates :total_appointments, length: { maximum: 3,  message: "Solo se permiten 3 caracteres" }
    validates :cost, length: { maximum: 7,  message: "Solo se permiten 7 caracteres" }
    validates :name, format: { with: /\A[a-zA-ZÀ-ÿ\-#_,;.:()0-9 ]+\z/, message: "No se permiten caracteres especiales, solo; # _ - ; . : , ()"  }
    validates :total_appointments, format: { with: /\A[0-9]+\z/, message: "Solo se permiten caracteres numericos" }
    validates :cost, format: { with: /\A[0-9.]+\z/, message: "Solo se permiten caracteres numericos" }

    has_many :patient_plans
    has_many :patients, through: :patient_plans

    has_many :medical_plans
    has_many :doctors, through: :medical_plans

    has_many :insured_patients


    def get_plan_code
        
        id_plan = Plan.maximum(:id)
        value = "0000"

        if (id_plan < 10 )
            puts "Opción A"
            value = "000".to_s + id_plan.to_s
        end
        if (id_plan > 10 && id_plan < 100 )
            puts "Opción B"
            value = "00".to_s + id_plan.to_s
        end
        if (id_plan > 100 && id_plan < 1000 )
            puts "Opción C"
            value = "0".to_s + id_plan.to_s
        end
        if (id_plan > 1000 && id_plan < 10000 )
            puts "Opción D"
            value = id_plan.to_s
        end
        
        return value
    end

    def plans_by_patient (patient)

        particular_plan = 0
        
        patient.patient_plans.each do |plan|

            if plan.type_plan == "Particular"  
                if plan.status == "Aprobado" || plan.status == "Pendiente" || plan.status == "Revision"
                    particular_plan = 2
                    break;
                end
            end

        end

        return particular_plan

    end

    def validate_name(str)
        expr = /\A[a-zA-ZÀ-ÿ\-#_,;.:()0-9 ]+\z/

        if expr.match(str)
            return true
        else
            return false
        end

    end

    def validate_num(str)
        expr = /\A[0-9.]+\z/

        if expr.match(str)
            return true
        else
            return false
        end
        
    end


end
