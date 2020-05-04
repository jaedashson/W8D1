class EditSubs < ActiveRecord::Migration[5.2]
  def change
    add_index :subs, :title, unique: true
    change_column :subs, :moderator_id, :integer, null: false
  end
end
