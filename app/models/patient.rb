class Patient < ApplicationRecord

    validates :name, :last_name, :document, :phone, :birthday, :address, presence: true

    validates :name, :last_name, length: { maximum: 40, message: "Solo se permiten 40 caracteres" }
    validates :document, length: { maximum: 9, message: "Solo se permiten 9 caracteres" }
    validates :phone, length: { maximum: 11, message: "Solo se permiten 11 caracteres" }
    validates :address, length: { maximum: 150,  message: "Solo se permiten 150 caracteres" }

    validates :phone, :document, format: { with: /\A[0-9]+\z/, message: "Solo se permiten caracteres numericos" }
    validates :name, :last_name, :middle_name, :surname, format: { with: /\A[a-zA-ZÀ-ÿ]+\z/, message: "Solo se permiten caracteres alfabeticos" }
    validates :address, format: { with: /\A[a-zA-ZÀ-ÿ\-#_,;.:()0-9 ]+\z/, message: "No se permiten caracteres especiales, solo; # _ - ; . : , ()" }

  

    belongs_to :user
    
    has_many :appointments
    has_many :doctors, through: :appointments

    has_many :chats
    has_many :doctors, through: :chats

    has_many :patient_plans
    has_many :plans, through: :patient_plans

    has_many :insured_patients
    has_many :insurances, through: :insured_patients

    has_many :insured_patients
    has_many :companies, through: :insured_patients

    def full_name
        [name, middle_name, last_name, surname].join(' ')
    end

    def set_status_masive
        @patients = Patient.where("status = 'Masivo'")

        @patients.update_all status:'activo'
    end

    def get_list_patient_by_csv(file)

        size_array = 0
        
        ###############split para obtneer filas del csv
        base64_string_decode_content_file = Base64.decode64(file)
        base64_string_decode_content_file.force_encoding(Encoding::UTF_8)
 
        array_content_file = base64_string_decode_content_file.gsub("\n",",").split(',')

        size_array = array_content_file.length

        #################### procesando filas csv y entrego un array
        row=0
        col = 0
        array_object = []
        next_string = ""
        
        while row < size_array do
            
        
            if array_content_file[col + 1] == nil
                break;
            end
        
            @object_patient = {
                email: array_content_file[col],
                name: array_content_file[col + 1],
                middle_name: array_content_file[col + 2],
                last_name: array_content_file[ col + 3],
                surname: array_content_file[col + 4],
                document: array_content_file[col + 5],
                gender: array_content_file[col + 6],
                phone: array_content_file[col + 7],
                marital_status: array_content_file[col + 8],
                birthay: array_content_file[col + 9],
                status_file: array_content_file[col + 10],
                plan_code: array_content_file[col + 11],
                insurance_code: array_content_file[col + 12],
                insurance_patient_code: array_content_file[col + 13],
                address: array_content_file[col + 14]
            }
            
            array_object.push(@object_patient)
            row = row + 15
            col = col + 15
        end

        puts "###############"
        puts array_object

        return array_object 
    end


    def save_patient_by_csv(obj) 
        value = false
        password = "mediChat123"

        obj[:array_object].each do |user|
        
            if User.exists?(email: user[:email])
                puts "El usuario ya existe."
                @patient = Patient.joins(:user).where("users.email = ?", user[:email])

                if user[:status_file].upcase == "Egresar".upcase || user[:status_file].upcase == "Egresado".upcase || user[:status_file].upcase == "Egreso".upcase
                    @patient[0].update_attribute(:status, "Inactivo")
                elsif user[:status_file].upcase == "Activo".upcase || user[:status_file].upcase == "Activar".upcase || user[:status_file].upcase == "Nuevo Ingreso".upcase 
                    @patient[0].update_attribute(:status, "Activo")
                end
                @patient[0].update_attribute(:status_file, user[:status_file])
                value = true
                
            else
                puts "El usario no existe"
                @user = User.new(user_type: "Paciente", email: user[:email], password: password, login_status: 'Logout',status: "Activo", busy: "Ocupado")

                if @user.save!(:validate => false)
                    puts "Creo usuario"
                    @patient = Patient.new(status: 'Activo',status_file: user[:status_file], name: user[:name], middle_name: user[:middle_name], last_name: user[:last_name], surname: user[:surname], document: user[:document], phone: user[:phone], gender: user[:gender], marital_status: user[:marital_status], mail: user[:email], user: @user)
                    if @patient.save!(:validate => false )
                        puts "Creo paciente"
                        #value = true
                        @insured_patient = InsuredPatient.new(status: "Activo", code: user[:insurance_patient_code], insurance_id: user[:insurance_code], patient:@patient, plan_id: user[:plan_code] , company_id: obj[:company_id])
                        
                        if @insured_patient.save!(:validate => false )
                            puts "se cfra registro de seguo de usuario"
                            value = true
                        else
                            puts "fallo "
                            value= false
                        end
                    
                    
                    else
                        puts "Fallo paciente"
                        value = false
                        break;
                    end
    
                else
                    puts "Fallo usuario"
                    value = false
                    break;
                end


            end

        end

        return value
    end


    #def total_patient_particular_vs_insured_by_doctor (doctor_id)
    def total_patient_particular_vs_insured_by_doctor (params)
        
        particular = 0
        secure = 0
        total = 0
        particularPorcentaje = 0
        securePorcentaje = 0

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
            @appointments = Appointment.where("doctor_id = ? AND created_at >= ? AND created_at <= ?",params[:doctor], params[:ini] , params[:end] )
        else
            if have_ini_value == true
                @appointments = Appointment.where("doctor_id = ? AND created_at >= ?", params[:doctor], params[:ini] )
            end
            if have_end_value == true
                @appointments = Appointment.where("doctor_id = ? AND created_at <= ?", params[:doctor], params[:end] )
            end
        end

        @appointments.each do |appointment|
            
            if appointment.patient.insured_patients.length > 0
                secure = secure + 1
            else
                particular = particular + 1
            end
        
        end
        
        total = particular + secure

        if total != 0 
            particularPorcentaje = ( particular * 100 ) / total
            securePorcentaje = ( secure * 100 ) / total
        end

        @total = {
            pie_total: total,
            pie_particular: particular,
            pie_secure: secure,
            pie_por_particular: particularPorcentaje,
            pie_por_secure: securePorcentaje
        }

        return @total
    
    end

    def total_patient_particular_vs_insured(params)
        
        particular = 0
        secure = 0
        total = 0
        particularPorcentaje = 0
        securePorcentaje = 0
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

        @appointments.each do |appointment|
            
            if appointment.patient.insured_patients.length > 0
                secure = secure + 1
            else
                particular = particular + 1
            end
        
        end
        
        total = particular + secure

        if total != 0 
            particularPorcentaje = ( particular * 100 ) / total
            securePorcentaje = ( secure * 100 ) / total
        end

        @total = {
            pie_total: total,
            pie_particular: particular,
            pie_secure: secure,
            pie_por_particular: particularPorcentaje,
            pie_por_secure: securePorcentaje
        }

        return @total
    
    end

    def total_patient_per_speciality (params)

        object_array = []
        array_to_hash = []
        array_aux = []
        value_key = ""
        value = ""
        count = 0
        pos = 0
        object_hash = Hash.new

        params[:appointments].each do |appointment|
            object_array.push(appointment.doctor.area_id)
        end

        params[:areas].each do |area|
            
            value_key = area.name
            object_array.each do |element|
                if area.id == element
                    count = count + 1
                end
            end
            object_hash[value_key.upcase] = count
            count = 0
             
        end

        return object_hash
    
    end

    def total_patient_per_diagnostic(params)
        
        object_array = []
        array_to_hash = nil
        value_key = ""
        value = ""
        count = 0
        object_hash = Hash.new
        
        params[:diagnostics].each do |diagnostic|
            object_array.push(diagnostic.code.upcase)
        end

        array_to_hash = object_array
        array_to_hash= array_to_hash.uniq

        array_to_hash.each do |element|

            value_key = element
            object_array.each do |diagnostic|
                
                if diagnostic.upcase == element.upcase
                    count =  count + 1
                end
                object_hash[value_key.upcase] = count
            end
            count = 0
            
        end

        return object_hash
    
    end

    def total_patient_per_insurance(params)

        object_array = []
        array_to_hash = nil
        value_key = ""
        value = ""
        count = 0
        object_hash = Hash.new

        params[:insurances].each do |insurance|
            insurance.insured_patients.each do |insurred_patient|
                object_array.push(insurance.name.upcase)
            end
        end

        puts "#########"
        puts object_array

        array_to_hash = object_array
        array_to_hash= array_to_hash.uniq

        
        puts "__________________"
        puts array_to_hash

        array_to_hash.each do |element|
            
            value_key = element
            object_array.each do |insurance|
                if insurance.upcase == element.upcase
                    count =  count + 1
                end
                object_hash[value_key.upcase] = count
            end
            count = 0

        end
        
        return object_hash
    end

    def total_patient_per_doctor(doctors)
        object_hash = Hash.new

        doctors.each do |doctor|
            name_doctor = doctor.name + " " + doctor.last_name
            object_hash[name_doctor] = count_patient_by_doctor(doctor.id)
        end

        return object_hash
    end


    def get_doctors(params)
        
        @doctors = nil
        have_ini_value = false
        have_end_value = false
        have_doctor = false
        date = Date.today

        if params[:ini] != "" && params[:ini] != nil
            have_ini_value = true
        end
        if params[:end] != "" && params[:ini] != nil
            have_end_value = true
        end
        if params[:doctor] != "" && params[:doctor] != nil
            have_doctor = true
        end

        if have_ini_value || have_end_value 

            if have_ini_value && have_end_value && have_doctor
                @doctors = Doctor.joins(:appointments).where("appointments.created_at >= ? AND appointments.created_at <= ? AND docors.last_name LIKE ?", params[:ini], params[:end], "%#{params[:doctor]}%").distinct
            elsif have_ini_value && have_doctor
                @doctors = Doctor.joins(:appointments).where("appointments.created_at >= ? AND docors.last_name LIKE ?", params[:ini], "%#{params[:doctor]}%").distinct
            elsif have_end_value && have_doctor
                @doctors = Doctor.joins(:appointments).where("appointments.created_at <= ? AND docors.last_name LIKE ?", params[:end], "%#{params[:doctor]}%").distinct
            elsif have_ini_value && have_end_value
                @doctors = Doctor.joins(:appointments).where("appointments.created_at >= ? AND appointments.created_at <= ?", params[:ini], params[:end]).distinct
            elsif have_ini_value
                @doctors = Doctor.joins(:appointments).where("appointments.created_at >= ?", params[:ini]).distinct
            elsif have_end_value
                @doctors = Doctor.joins(:appointments).where("appointments.created_at <= ?", params[:end]).distinct
            end
        else
            if have_doctor
                @doctors = Doctor.where("last_name LIKE ?", "%#{params[:doctor]}%")
            end
        end

        if have_ini_value == false && have_end_value == false && have_doctor == false
            @doctors = Doctor.joins(:appointments).where("appointments.created_at >= ?", date.year.to_s + "-" + date.month.to_s + "-01").distinct
        end
    
        return @doctors
    end

    def get_list_doctors(doctors)

        doctors_id = 0

        @doctors.each do |doctor|
            doctors_id = doctors_id.to_s + "," + doctor.id.to_s
        end
    
        return doctors_id
    end

    def get_doctors_by_date(params)

        have_ini_value = false
        have_end_value = false
        date = Date.today
        doctors_id = "1"

        @doctors = Doctor.joins(:appointments).where("appointments.created_at >= ?", date.year.to_s + "-" + date.month.to_s + "-01").select(:id).distinct

        if params[:ini] != "" && params[:ini] != nil
           have_ini_value = true
        end

        if params[:end] != "" && params[:ini] != nil
            have_end_value = true
        end
        
        if have_ini_value == true && have_end_value == true
           
            @doctors = Doctor.joins(:appointments).where("appointments.created_at >= ? AND appointments.created_at <= ?", params[:ini], params[:end]).select(:id).distinct
        else
            if have_ini_value == true
                @doctors = Doctor.joins(:appointments).where("appointments.created_at >= ?", params[:ini]).select(:id).distinct
            end
            if have_end_value == true
                @doctors = Doctor.joins(:appointments).where("appointments.created_at <= ?", params[:end]).select(:id).distinct
            end
        end

        @doctors.each do |doctor|
           doctors_id = doctors_id + "," + doctor.id.to_s
        end

        return doctors_id

    end


    def validate_insurance_code(str)
        expr = /\A[a-zA-ZÀ-ÿ\-#_,;.:()0-9 ]+\z/

        if expr.match(str)
            return true
        else
            return false
        end
    end

    def validate_insurance_company (insurance)

        if insurance != nil && insurance != ""
            return true
        else
            return false
        end

    end

    private
    #def count_patient_by_area(params)

     #   total= 0
      #  have_ini_value = false
       # have_end_value = false
        #date = Date.today

        #@area = Area.where("name = ?", params[:area])
        #@doctors = Doctor.where("area_id = ?", @area[0].id)

       # @doctors.each do |doctor|

        #    @appointments = Appointment.where("doctor_id = ? AND created_at >= ?", doctor.id, date.year.to_s + "-" + date.month.to_s + "-01"  )

        #    if params[:ini] != "" && params[:ini] != nil
         #       have_ini_value = true
         #   end

         #   if params[:end] != "" && params[:ini] != nil
         #       have_end_value = true
         #   end
            
         #   if have_ini_value == true && have_end_value == true
         #       @appointments = Appointment.where("doctor_id = ? AND created_at >= ? AND created_at <= ?", doctor.id, params[:ini] , params[:end] )
         #   else
         #       if have_ini_value == true
         #           @appointments = Appointment.where("doctor_id = ? AND created_at >= ?", doctor.id,  params[:ini] )
         #       end
         #       if have_end_value == true
         #           @appointments = Appointment.where("doctor_id = ? AND  created_at <= ?", doctor.id , params[:end] )
         #       end
         #   end
          #  total = total + @appointments.length
        
       # end

        #return total
    
    #end

    #def count_patient_by_diagnostic(params) 

        #have_ini_value = false
        #have_end_value = false
        #have_diagnostic = false
        #date = Date.today
    
        #@patients = Diagnostic.where("upper(code) = ? AND created_at >= ? ", params[:diagnostic].upcase, date.year.to_s + "-" + date.month.to_s + "-01" )
    
        #if params[:ini] != "" && params[:ini] != nil
        #    have_ini_value = true
        #end
    
        #if params[:end] != "" && params[:ini] != nil
        #    have_end_value = true
        #end

        #if params[:diagnostic] != "" && params[:diagnostic] != nil
         #   have_diagnostic = true
        #end
        
        #if have_ini_value && true && have_end_value == true
         #   @patients = Diagnostic.where("upper(code) = ? AND created_at >= ? AND created_at <= ?", params[:diagnostic].upcase, params[:ini] , params[:end] )
        #elsif have_ini_value == true
         #   @patients = Diagnostic.where("upper(code) = ? AND created_at >= ? ", params[:diagnostic].upcase, params[:ini])
        #elsif have_end_value == true
         #   @patients = Diagnostic.where("upper(code) = ? AND created_at <= ?", params[:diagnostic].upcase, params[:end] )
       # elsif have_diagnostic
        #    @patients = Diagnostic.where("upper(code) = ?", params[:diagnostic].upcase )
      #  end
    
     #   return @patients.length
    #end

    #def count_patient_by_insurance(params)

        #have_ini_value = false
        #have_end_value = false
        #date = Date.today

        #@patients = InsuredPatient.where("insurance_id = ? AND created_at >= ?", params[:insurance], date.year.to_s + "-" + date.month.to_s + "-01" )

        #if params[:ini] != "" && params[:ini] != nil
         #   have_ini_value = true
        #end

        #if params[:end] != "" && params[:ini] != nil
         #   have_end_value = true
        #end
        
        #if have_ini_value == true && have_end_value == true
         #   @patients = InsuredPatient.where("insurance_id = ? AND created_at >= ? AND created_at <= ?", params[:insurance], params[:ini], params[:end])
        #else
            #if have_ini_value == true
           #     @patients = InsuredPatient.where("insurance_id = ? AND created_at >= ?", params[:insurance], params[:ini])
          #  end
         #   if have_end_value == true
       #         @patients = InsuredPatient.where("insurance_id = ? AND created_at <= ?", params[:insurance], params[:end])
        #    end
      #  end

     #   return @patients.length
    #end

    def count_patient_by_doctor(doctor_id)

        @patients = Appointment.where("doctor_id = ?", doctor_id)

        return @patients.length
    end

end
