class CreateUserGropu < ActiveRecord::Migration[5.1]
  def change
    create_table :user_gropus do |t|
      t.string :login
      t.string :group
      t.string :won_staff
      t.timestamps
    end
  end
end
