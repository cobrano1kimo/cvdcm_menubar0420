class CreateLdapRoleUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :ldap_role_users, id: false  do |t|
      t.integer :department_id
      t.integer :role_id
      t.integer :user_id
      t.string :department
      t.string :role
      t.string :user

      t.timestamps
    end
      add_index :ldap_role_users, [:department, :role, :user], unique: true
  end
end
