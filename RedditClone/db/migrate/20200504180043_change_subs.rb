class ChangeSubs < ActiveRecord::Migration[5.2]
  def change
    change_column :subs, :description, :text
  end
end
