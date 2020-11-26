class AddPaymonthToCustomerTmps < ActiveRecord::Migration[5.1]
  def change

    add_column(:customer_tmps,:paymonth01, :string,:limit => 2)
      add_column(:customer_tmps,:paymonth02, :string,:limit => 2)
        add_column(:customer_tmps,:paymonth03, :string,:limit => 2)
          add_column(:customer_tmps,:paymonth04, :string,:limit => 2)
            add_column(:customer_tmps,:paymonth05, :string,:limit => 2)
              add_column(:customer_tmps,:paymonth06, :string,:limit => 2)
                add_column(:customer_tmps,:paymonth07, :string,:limit => 2)
                  add_column(:customer_tmps,:paymonth08, :string,:limit => 2)
                    add_column(:customer_tmps,:paymonth09, :string,:limit => 2)
                      add_column(:customer_tmps,:paymonth10, :string,:limit => 2)
                        add_column(:customer_tmps,:paymonth11, :string,:limit => 2)
                          add_column(:customer_tmps,:paymonth12, :string,:limit => 2)
  end
end
