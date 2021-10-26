class Chat < ApplicationRecord
  belongs_to :doctor
  belongs_to :patient

  has_many :messages

  scope :by_doctor, -> (doctor_id) { where(doctor_id: doctor_id) }

end
