class CreateLdapRoles < ActiveRecord::Migration[5.1]
  def change
    create_table :ldap_roles, id: false do |t|
      t.primary_key :usncreated
      t.string :name
      t.string :department
      t.string :mail
      t.datetime :whencreated
      t.datetime :whenchanged

      t.timestamps
    end
  end
end
