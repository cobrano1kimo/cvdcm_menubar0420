class AddEmailToUserGroup < ActiveRecord::Migration[5.1]
  def change
    add_column(:user_groups,:email,:string,:limit => 256)
  end
end
