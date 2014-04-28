ActiveAdmin.register MenuItem do
	config.filters = false
	config.paginate = false

	sortable tree: true

	permit_params :title, :url

	menu label: "Menu"

	index as: :sortable do
		label "Title" do |menu_item|
			link_to menu_item.title, edit_admin_menu_item_path( menu_item )
		end
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

	controller do
		def create
			create! do |format|
				format.html { redirect_to_index }
			end
		end

		def update
			update! do |format|
				format.html { redirect_to_index }
			end
		end

		private

			def redirect_to_index
				redirect_to admin_menu_items_url
			end
	end
end
