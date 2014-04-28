class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title
      t.string :slug
      t.string :template
      t.text :properties

      t.timestamps
    end
  end
end
