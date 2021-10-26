class User < ApplicationRecord

  has_one :doctor
  has_one :patient
  has_many :messages

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  scope :doctors, -> { where.not(user_type: 'Paciente') }
  scope :patients, -> { where(user_type: 'Paciente') }

  def doctor?
    user_type.downcase.parameterize == 'medico'
  end

  def patient?
    user_type.downcase.parameterize == 'paciente'
  end

  def full_name
    return doctor.full_name if doctor.present?
    return patient.full_name if patient.present?
  end

  def get_password_size (password)

    return password.size
  end 

  def validate_empty_valiue (value)

    have_email = false
    have_type = false

    if value[:email] != nil && value[:email] != ""
      have_email= true
    end

    if value[:type] != nil && value[:type] != ""
      have_type = true
    end

    if have_email && have_type
      return true
    else
      return false
    end
  
  end

  #def get_type_user (current_user)
    
   # value = nil
    
    #if current_user.user_type.upcase == "Principal".upcase
     # value = "Medico"
    #end

    #if current_user.user_type.upcase == "Convenio".upcase
     #   value = "Paciente"
    #end

    #return value
  
  #end

end
