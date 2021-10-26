class MessagePolicy < ApplicationPolicy
  def patient?
    user.patient? && record.chat.patient.user_id == user.id
  end

  def doctor?
    user.doctor? && record.chat.doctor.user_id == user.id
  end

  def index?
    user.doctor? || user.patient?
  end

  def create?
    index?
  end
end
