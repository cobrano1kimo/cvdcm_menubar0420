class CreateLdapUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :ldap_users, id: false do |t|
      t.primary_key :usncreated
      t.string :samaccountname
      t.string :name
      t.string :department
      t.string :title
      t.string :mail
      t.string :info
      t.string :description
      t.string :telephonenumber
      t.string :facsimiletelephonenumber
      t.datetime :whencreated
      t.datetime :whenchanged
      t.datetime :accountexpires

      t.timestamps
    end
  end
end
