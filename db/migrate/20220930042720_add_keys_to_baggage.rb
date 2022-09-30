class AddKeysToBaggage < ActiveRecord::Migration[7.0]
  def change
    add_reference :baggages, :user, null: false, foreign_key: true
    add_reference :baggages, :reservation, null: false, foreign_key: true
  end
end
