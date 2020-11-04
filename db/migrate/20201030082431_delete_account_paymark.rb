class DeleteAccountPaymark < ActiveRecord::Migration[5.1]
  def change
      remove_column(:accounts,:paymark)
  end
end
