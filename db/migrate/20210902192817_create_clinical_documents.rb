class CreateClinicalDocuments < ActiveRecord::Migration[6.1]
  def change
    create_table :clinical_documents do |t|

      t.text :info

      t.timestamps

      t.references :appointment, index: true
    end
  end
end
