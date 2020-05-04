class AddIndexToSubs < ActiveRecord::Migration[5.2]
  def change
    add_index :subs, :moderator_id
  end
end
