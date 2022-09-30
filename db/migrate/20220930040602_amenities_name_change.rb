class AmenitiesNameChange < ActiveRecord::Migration[7.0]
  def change
    rename_column :reservations, :amenitites, :amenities
  end
end
