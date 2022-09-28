class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :user_id
      t.string :credit_card_no
      t.string :address
      t.string :mobile
      t.string :email
      t.boolean :is_admin

      t.timestamps
    end
    add_index :users, :user_id, unique: true
  end
end
