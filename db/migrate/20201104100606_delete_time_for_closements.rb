class DeleteTimeForClosements < ActiveRecord::Migration[5.1]
  def change
    remove_column(:closements,:created_at)
      remove_column(:closements,:updated_at)
  end
end
