class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.references :recipient, foreign_key: { to_table: :users }, null: false
      t.references :sender, foreign_key: { to_table: :users }, null: false
      t.references :conversation, foreign_key: true
      t.text :content, null: false
      t.timestamps
    end
  end
end
