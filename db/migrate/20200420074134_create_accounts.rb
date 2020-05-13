class CreateAccounts < ActiveRecord::Migration[5.1]
  def change

    create_table :accounts do |t|

        t.string :acc_kind
        t.string :acc_no
        t.string :acc_date
        t.integer :acc_cost
        t.string :cust_id ,limit: 5
        t.string :cust_type
        t.datetime :cre_date
        t.string :acc_note

      t.timestamps
  
    end

  end
end
