class CreateReports < ActiveRecord::Migration[6.1]
  def change
    create_table :reports do |t|
      t.text :reason
      t.text :disease
      t.text :past
      t.text :exam
      t.text :diagnostic
      t.text :prescription_des
      t.text :medicine
      t.text :use
      t.date :report_date
      
      t.timestamps

      t.references :appointment, index: true
    end
  end
end
