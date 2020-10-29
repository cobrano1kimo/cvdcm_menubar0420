class AddPaymarkToAccounts < ActiveRecord::Migration[5.1]
  def change
      add_column(:accounts,:paymark,:string,:limit => 1)
  end
end
