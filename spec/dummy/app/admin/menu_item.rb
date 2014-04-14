ActiveAdmin.register MenuItem do
	config.filters = false
	config.paginate = false

	permit_params :title, :url

	menu label: "Menu"

	index do
		column "Title" do |menu_item|
			link_to menu_item.title, edit_admin_menu_item_path( menu_item )
		end

		column :url
		actions defaults: false do |menu_item|
			link_to "Delete", admin_menu_item_path( menu_item ), method: "delete", confirm: "Are you sure?"
		end
	end

	form do |f|
		f.inputs "Details" do
			f.input :title
			f.input :url
		end

		f.actions
	end
end
