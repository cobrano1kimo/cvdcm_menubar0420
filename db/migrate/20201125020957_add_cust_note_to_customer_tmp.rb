class AddCustNoteToCustomerTmp < ActiveRecord::Migration[5.1]
  def change
    add_column :customer_tmps, :cust_note,:string
  end
end
