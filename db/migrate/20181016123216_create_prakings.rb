class CreatePrakings < ActiveRecord::Migration[5.1]
  def change
    create_table :parkings do |t|
      t.date :valid_from
      t.date :valid_to
      t.references :reservation, foreign_key: true

      t.timestamps
    end
  end
end
