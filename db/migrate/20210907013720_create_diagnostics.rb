class CreateDiagnostics < ActiveRecord::Migration[6.1]
  def change
    create_table :diagnostics do |t|

      t.string :code
      t.string :diagnostic
      t.timestamps

      t.references :report, index: true

    end
  end
end
