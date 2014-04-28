class ExtendPagesTable < ActiveRecord::Migration
  def change
	  change_table :pages do |t|
		  t.integer :position
		  t.index :slug, unique: true
	  end
  end
end
