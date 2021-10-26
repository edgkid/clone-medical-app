class ChatPolicy < ApplicationPolicy
  def index?
    true
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
