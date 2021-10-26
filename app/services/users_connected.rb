class UsersConnected
  @doctors = []
  @patients = []
  attr_accessor :id, :full_name, :speciality, :started, :doctor_id

  def initialize(user)
    self.id = user.id
    self.doctor_id = user.try(:doctor).try(:id)
    self.full_name = user.full_name
    self.speciality = user.try(:doctor).try(:specialty)
    self.started = Time.zone.now
  end

  def self.remove(user)
    if user.doctor?
      remove_doctor(user.id)
    else
      remove_patient(user.id)
    end
  end

  def self.remove_doctor(id)
    index = @doctors.index { |c| c.id == id }
    @doctors.delete_at(index) if index.present?
  end

  def self.remove_patient(id)
    index = @patients.index { |c| c.id == id }
    @patients.delete_at(index) if index.present?
  end

  def self.create(user)
    user_connected = UsersConnected.new user
    if user.doctor?
      @doctors << user_connected
    else
      @patients << user_connected
    end

    user_connected
  end

  def self.doctors_gets
    @doctors
  end

  def self.patients_gets
    @patients
  end

  class << self
    attr_accessor :users
  end
end
