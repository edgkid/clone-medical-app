class Doctor < ApplicationRecord

    validates :name, :last_name, :document, :phone, :birthday, :address, :specialty, presence: true

    validates :name, :last_name, :specialty, length: { maximum: 40, message: "Solo se permiten 40 caracteres" }
    validates :document, length: { maximum: 9, message: "Solo se permiten 9 caracteres" }
    validates :phone, length: { maximum: 11, message: "Solo se permiten 11 caracteres" }
    validates :address, length: { maximum: 150,  message: "Solo se permiten 150 caracteres" }

    validates :phone, :document, format: { with: /\A[0-9]+\z/, message: "Solo se permiten caracteres numericos" }
    validates :name, :last_name, :middle_name, :surname, format: { with: /\A[a-zA-ZÀ-ÿ]+\z/, message: "Solo se permiten caracteres alfabeticos" }
    validates :specialty, format: { with: /\A[a-zA-ZÀ-ÿ ]+\z/, message: "Solo se permiten caracteres alfabeticos" }
    validates :address, format: { with: /\A[a-zA-ZÀ-ÿ\-#_,;.:()0-9 ]+\z/, message: "No se permiten caracteres especiales, solo; # _ - ; . : , ()" }


    belongs_to :user
    belongs_to :area

    has_many :chats
    has_many :patients, through: :chats

    has_many :appointments
    has_many :patients, through: :appointments

    has_many :medical_plans
    has_many :plans, through: :medical_plans

    def full_name
        [name, middle_name, last_name, surname].join(' ')
    end


    def set_status_masive
        @doctors = Doctor.where("status = 'Masivo'")

        @doctors.update_all status:'activo'
    end

    def get_list_patient_by_csv(file)

        size_array = 0
        
        ###############split para obtneer filas del csv
        base64_string_decode_content_file = Base64.decode64(file)

        puts base64_string_decode_content_file.force_encoding(Encoding::UTF_8)
        puts '###############################################'
        
        array_content_file = base64_string_decode_content_file.split(',')

        size_array = array_content_file.length

        #################### procesando filas csv y entrego un array
        row=0
        col = 0
        array_object = []

        while row < size_array do
            

            if array_content_file[col + 1] == nil
                break;
            end

            @object_patient = {
                email: row >0 ? array_content_file[col].slice(2..array_content_file[col].length )  : array_content_file[col],
                name: array_content_file[col + 1],
                middle_name: array_content_file[col + 2],
                last_name: array_content_file[ col + 3],
                surname: array_content_file[col + 4],
                document: array_content_file[col + 5],
                gender: array_content_file[col + 6],
                phone: array_content_file[col + 7],
                specialty: array_content_file[col + 8],
                birthay: array_content_file[col + 9],
                status_file: array_content_file[col + 10],
                address: array_content_file[col + 11]
                
            }
            
            array_object.push(@object_patient)
            row = row + 12
            col = col + 12

        end

        return array_object 
    end


    def save_patient_by_csv(array_object) 
        value = false

        user_register = ""
        array_object.each do |user|
            user_register = user[:email]
            @user = User.new(user_type: "Medico", email: user[:email], password:"123456", login_status: 'Logout', status: "Activo", busy: "Ocupado")

            if User.exists?(email: user[:email])
                puts "el usuario ya existe."

                if user[:status_file].upcase == "Egresar".upcase || user[:status_file].upcase == "Egresado".upcase || user[:status_file].upcase == "Egreso".upcase
                    @user = User.where("email = ?", user[:email])
                    @doctor = Doctor.where("user_id = ?", @user[0].id)
                    #@doctor.status = "Inactivo"
                    #@doctor[0].status_file = user[:status_file]
                    @doctor[0].update_attribute :status_file, user[:status_file]
                end
                
            else
                if user[:status_file].upcase != "Egresar".upcase || user[:status_file].upcase != "Egresado".upcase || user[:status_file].upcase != "Egreso".upcase
                    if @user.save!(:validate => false)

                        @doctor = Doctor.new(status: 'Masivo', status_file: user[:status_file], name: user[:name], middle_name: user[:middle_name], last_name: user[:last_name], surname: user[:surname], document: user[:document], phone: user[:phone], gender: user[:gender], specialty: user[:specialty], mail: user[:email], user: @user)
                        if @doctor.save!(:validate => false )
                            value = true
                        else
                            value = false
                            break;
                        end
        
                    else
                        value = false
                        break;
                    end
                end
                
            end
        end

        return value
    end

end
