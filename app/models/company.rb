class Company < ApplicationRecord

    has_many :insured_patients
    has_many :patients, through: :insured_patients

    has_many :insured_patients
    has_many :insurances, through: :insured_patients

    def get_company_id_by_name (company)
        id = 0

        @company = Company.where("name = ?", "IBM")

        if @company.length > 0
            id = @company[0].id
        else

        end

        return id
    end

end
