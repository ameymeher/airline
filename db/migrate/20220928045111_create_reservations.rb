class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.string :reservation_id
      t.integer :no_of_passengers
      t.string :ticket_class
      t.string :amenitites
      t.integer :no_of_baggage
      t.decimal :cost

      t.timestamps
    end
    add_index :reservations, :reservation_id, unique: true
  end
end
