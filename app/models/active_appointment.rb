class ActiveAppointment < ApplicationRecord

    belongs_to :appointment
    belongs_to :patient_plan
end
