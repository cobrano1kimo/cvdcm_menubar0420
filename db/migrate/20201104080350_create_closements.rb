class CreateClosements < ActiveRecord::Migration[5.1]
  def change
    create_table :closements do |t|
      t.integer :close_day

      t.timestamps
    end
  end
end
