class CreateMenuItems < ActiveRecord::Migration
  def change
    create_table :menu_items do |t|
      t.string :title
      t.string :url
      t.references :parent, index: true
      t.integer :position

      t.timestamps
    end
  end
end
