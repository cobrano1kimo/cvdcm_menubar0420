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
      t.boolean :is_disable_account, :default => false
      t.boolean :is_left_job, :default => false
      t.boolean :is_retired, :default => false

      t.timestamps
    end
  end
end
