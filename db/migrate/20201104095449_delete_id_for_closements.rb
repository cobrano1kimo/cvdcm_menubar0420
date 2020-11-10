class DeleteIdForClosements < ActiveRecord::Migration[5.1]
  def change
    remove_column(:closements,:id)
  end
end
