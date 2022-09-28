class CreateFlights < ActiveRecord::Migration[7.0]
  def change
    create_table :flights do |t|
      t.string :name
      t.string :flight_id
      t.string :class
      t.string :manufacturer
      t.string :source_city
      t.string :destination_city
      t.integer :capacity
      t.string :status
      t.decimal :cost

      t.timestamps
    end
    add_index :flights, :flight_id, unique: true
  end
end
