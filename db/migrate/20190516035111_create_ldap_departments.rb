class CreateLdapDepartments < ActiveRecord::Migration[5.1]
  def change
    create_table :ldap_departments, id: false do |t|
      t.primary_key :usncreated
      t.string :name
      t.string :description
      t.datetime :whencreated
      t.datetime :whenchanged

      t.timestamps
    end
  end
end
