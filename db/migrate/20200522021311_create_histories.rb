class CreateHistories < ActiveRecord::Migration[5.1]
  def change
    create_table :histories do |t|
      t.string :acc_kind
      t.string :no_bef
      t.string :no_aft
      t.string :acc_date
      t.integer :cost_bef
      t.integer :cost_aft
      t.string :cust_id
      t.string :mark
      t.string :user_id
      t.string :type_bef
      t.string :type_aft
      t.string :note_bef
      t.string :note_aft
      t.timestamps
    end
  end
end
