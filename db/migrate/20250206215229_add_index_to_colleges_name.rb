class AddIndexToCollegesName < ActiveRecord::Migration[5.2]
  def change
  	add_index :colleges, :name
  end
end
