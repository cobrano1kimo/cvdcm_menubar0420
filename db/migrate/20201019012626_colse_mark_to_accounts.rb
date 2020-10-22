class ColseMarkToAccounts < ActiveRecord::Migration[5.1]
  def change
    add_column(:accounts,:clo_mark,:string,:limit => 1)
    add_column(:accounts,:clo_date,:datetime)
  end
end
