class InsuredPatient < ApplicationRecord

    belongs_to :insurance
    belongs_to :patient
    belongs_to :plan
    belongs_to :company

end
