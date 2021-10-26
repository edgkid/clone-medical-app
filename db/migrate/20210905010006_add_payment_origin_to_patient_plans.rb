class AddPaymentOriginToPatientPlans < ActiveRecord::Migration[6.1]
  def change
    add_column :patient_plans, :payment_to, :string
  end
end
