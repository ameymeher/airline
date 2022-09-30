class ChangeFlighId < ActiveRecord::Migration[7.0]
  def change
    rename_column :flights, :flight_id, :confirmation_no
  end
end
