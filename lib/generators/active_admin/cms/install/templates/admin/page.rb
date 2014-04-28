ActiveAdmin.register Page do
	form partial: "form"
	filter :title

	config.sort_order = "position_asc"
	config.paginate = false

	sortable
	
	controller do
		def permitted_params
			params.permit!
		end

		def find_resource
			scoped_collection.friendly.find( params[ :id ] )
		end

		def update
			update! do |format|
				format.html { redirect_to_page_editing }
			end
		end

		def create
			create! do |format|
				format.html { redirect_to_page_editing }
			end
		end

		private

			def redirect_to_page_editing
				redirect_to edit_admin_page_url( @page.friendly_id )
			end
	end

	index as: :sortable do
		label "Title" do |page|
			link_to page.title, edit_admin_page_path( page )
		end
		actions defaults: false do |page|
			link_to "Delete", admin_page_path( page ), method: "delete", confirm: "Are you sure you want to delete this?" 
		end
	end
end
