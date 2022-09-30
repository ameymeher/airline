class ClassNameChange < ActiveRecord::Migration[7.0]
  def change
    rename_column :flights, :class, :ticket_class
  end
end
