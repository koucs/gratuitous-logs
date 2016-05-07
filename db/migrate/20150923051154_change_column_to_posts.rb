class ChangeColumnToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :is_valid, :boolean, null: false, default: true
    add_column :posts, :is_draft, :boolean, null: false, default: false
  end
end
