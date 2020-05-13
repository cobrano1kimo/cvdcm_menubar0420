class CreateCustomers < ActiveRecord::Migration[5.1]
  def change

    create_table :customers ,id: false do |t|
      t.string :cust_id ,primary_key: true, limit: 5, default: ''
      t.string :cust_name
      t.string :cust_nick
      t.string :cust_stat
      t.string :won_staff
      t.string :cust_note
      t.timestamps
      t.references(:accounts)
      t.belongs_to(:accounts, foreign_key: true)
    end


  end
end
