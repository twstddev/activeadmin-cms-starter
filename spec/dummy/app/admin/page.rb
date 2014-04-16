ActiveAdmin.register Page do
	controller do
		def permitted_params
			params.permit!
		end

		def find_resource
			scoped_collection.friendly.find( params[ :id ] )
		end
	end

	form do |f|
		f.inputs "General" do
			f.input :title
			f.input :slug
			f.input :template, as: :select, collection: Page.templates
		end

		f.actions
	end
end
