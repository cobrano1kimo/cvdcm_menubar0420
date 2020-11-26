class CreateCustomerTmps < ActiveRecord::Migration[5.1]
  def change
    create_table :customer_tmps,id: false do |t|
      t.string :cust_id ,primary_key: true, limit: 5, default: ''
      t.string :cust_name
      t.string :cust_stat
      t.string :won_staff
      t.string :cust_payment, limit: 2
    end
  end
end
