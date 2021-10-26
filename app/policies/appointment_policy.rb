class AppointmentPolicy < ApplicationPolicy
  def index?
    user.patient?
  end

  def create?
    user.patient?
  end

  def show?
    (user.patient? || user.doctor?) &&
      (record.doctor.user_id == user.id ||
      record.patient.user_id == user.id)
  end

  class Scope < Scope
    def resolve
      scope.where(patient: user)
    end
  end
end
