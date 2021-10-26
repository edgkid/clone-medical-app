class CreateOffers < ActiveRecord::Migration[6.1]
  def change
    create_table :offers do |t|

      t.string :description
      t.string :code_offer
      t.string :status
      t.text :image

      t.timestamps
    end
  end
end
