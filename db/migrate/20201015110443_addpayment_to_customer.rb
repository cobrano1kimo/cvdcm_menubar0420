class AddpaymentToCustomer < ActiveRecord::Migration[5.1]
  def change
    add_column(:customers,:cust_payment,:string,:limit => 2)
    add_column(:customers,:cust_payday,:string,:limit => 2)
    add_column(:customers,:paymonth01, :string,:limit => 2)
      add_column(:customers,:paymonth02, :string,:limit => 2)
        add_column(:customers,:paymonth03, :string,:limit => 2)
          add_column(:customers,:paymonth04, :string,:limit => 2)
            add_column(:customers,:paymonth05, :string,:limit => 2)
              add_column(:customers,:paymonth06, :string,:limit => 2)
                add_column(:customers,:paymonth07, :string,:limit => 2)
                  add_column(:customers,:paymonth08, :string,:limit => 2)
                    add_column(:customers,:paymonth09, :string,:limit => 2)
                      add_column(:customers,:paymonth10, :string,:limit => 2)
                        add_column(:customers,:paymonth11, :string,:limit => 2)
                          add_column(:customers,:paymonth12, :string,:limit => 2)
  end
end
