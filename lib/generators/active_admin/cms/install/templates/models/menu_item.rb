class MenuItem < ActiveRecord::Base
	has_many :children, class_name: "MenuItem", foreign_key: "parent_id"
	belongs_to :parent, class_name: "MenuItem"

	validates :title, :url, presence: true

	def self.roots 
		MenuItem.where( parent_id: nil )
	end
end
