class Insurance < ApplicationRecord

    has_many :insured_patients
    has_many :patients, through: :insured_patients

    has_many :insured_patients
    has_many :companies, through: :insured_patients

    validates :name, presence: true

    validates :name, length: { maximum: 40, message: "Solo se permiten 40 caracteres" }

    validates :name, format: { with: /\A[0-9a-zA-ZÀ-ÿ ]+\z/, message: "Solo se permiten caracteres alfanumericos" }


    def get_insurances(params)
        
        @insurances = nil
        have_ini_value = false
        have_end_value = false
        have_company = false
        have_insurance = false
        date = Date.today

        if params[:ini] != "" && params[:ini] != nil
            have_ini_value = true
        end

        if params[:end] != "" && params[:ini] != nil
            have_end_value = true
        end

        if params[:company] != "" && params[:company] != nil
            have_company = true
        end

        if params[:insurance] != "" && params[:insurance] != nil
            have_insurance = true
        end

        if have_ini_value || have_end_value  
            
            if have_ini_value && have_end_value && have_company && have_insurance
                
                @insurances = Insurance.joins(:insured_patients).joins(:companies).where("insured_patients.created_at >= ? AND insured_patients.created_at <= ? AND insurances.name like ? AND companies.name LIKE ?", params[:ini] , params[:end],"%#{params[:insurance]}%", "%#{params[:company]}%").distinct
            elsif have_ini_value && have_company && have_insurance

                @insurances = Insurance.joins(:insured_patients).joins(:companies).where("insured_patients.created_at >= ? AND insurances.name like ? AND companies.name LIKE ?", params[:ini],"%#{params[:insurance]}%", "%#{params[:company]}%").distinct
            elsif have_end_value && have_company && have_insurance
                
                @insurances = Insurance.joins(:insured_patients).joins(:companies).where("insured_patients.created_at <= ? AND insurances.name like ? AND companies.name LIKE ?", params[:end],"%#{params[:insurance]}%", "%#{params[:company]}%").distinct
            elsif have_ini_value && have_end_value && have_company
                
                @insurances = Insurance.joins(:insured_patients).joins(:companies).where("insured_patients.created_at >= ? AND insured_patients.created_at <= ? AND companies.name LIKE ?", params[:ini] , "%#{params[:insurance]}%", "%#{params[:company]}%").distinct
            elsif have_ini_value && have_end_value && have_insurance
                
                @insurances = Insurance.joins(:insured_patients).where("insured_patients.created_at >= ? AND insured_patients.created_at <= ? AND insurances.name like ?", params[:ini] , params[:end],"%#{params[:insurance]}%").distinct
            elsif have_ini_value && have_end_value 
                
                @insurances = Insurance.joins(:insured_patients).where("insured_patients.created_at >= ? AND insured_patients.created_at <= ?", params[:ini] , params[:end]).distinct
            elsif have_ini_value && have_company
                
                @insurances = Insurance.joins(:insured_patients).joins(:companies).where("insured_patients.created_at >= ? AND companies.name LIKE ?", params[:ini],"%#{params[:insurance]}%", "%#{params[:company]}%").distinct
            elsif have_ini_value && have_insurance
                
                @insurances = Insurance.joins(:insured_patients).where("insured_patients.created_at >= ? AND insurances.name like ?", params[:ini],"%#{params[:insurance]}%").distinct
            elsif have_end_value && have_company
                
                @insurances = Insurance.joins(:insured_patients).joins(:companies).where("insured_patients.created_at <= ? AND companies.name LIKE ?", params[:end],"%#{params[:insurance]}%", "%#{params[:company]}%").distinct
            elsif have_end_value && have_insurance
                
                @insurances = Insurance.joins(:insured_patients).where("insured_patients.created_at <= ? AND insurances.name like ?", params[:end],"%#{params[:insurance]}%").distinct
            elsif have_ini_value 
                
                @insurances = Insurance.joins(:insured_patients).where("insured_patients.created_at >= ?", params[:ini]).distinct
            elsif have_end_value
                
                @insurances = Insurance.joins(:insured_patients).where("insured_patients.created_at <= ?", params[:end]).distinct
            end


        else

            if have_company && have_insurance
                
                @insurances = Insurance.joins(:insured_patients).joins(:companies).where("insurances.name like ? AND companies.name LIKE ?","%#{params[:insurance]}%", "%#{params[:company]}%").distinct
            else

                if have_company
                   
                    @insurances = Insurance.joins(:insured_patients).joins(:companies).where("companies.name LIKE ?", "%#{params[:company]}%").distinct
                end

                if have_insurance   
                    
                    @insurances = Insurance.joins(:insured_patients).where("insurances.name LIKE ?", "%#{params[:insurance]}%").distinct
                end

            end

        end

        if have_ini_value == false && have_end_value == false && have_company == false && have_insurance == false
            
            @insurances = Insurance.joins(:insured_patients).where("insured_patients.created_at >= ?", date.year.to_s + "-" + date.month.to_s + "-01"  ).distinct
        end

        return @insurances
    
    end
  
end
