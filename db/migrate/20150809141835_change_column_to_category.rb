class ChangeColumnToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :image_url, :string, null: false, default: ""
    add_column :categories, :description, :string, null: false, default: ""
  end
end
