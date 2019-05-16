class CreateMenubars < ActiveRecord::Migration[5.1]
  def change
    create_table :menubars, id: false do |t|
      t.string :menu_id, primary_key: true, limit: 8, default: ''
      t.string :menu_name, limit: 40, default: ''
      t.string :parent_menu_id, limit: 6, default: ''
      t.integer :menu_sn, default: 0
      t.string :program_id, default: ''
      t.string :program_url, default: ''
      t.integer :lock_version, defalut: 0, null: false

      t.timestamps
    end
  end
end
