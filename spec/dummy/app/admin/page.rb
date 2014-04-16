ActiveAdmin.register Page do
	controller do
		def permitted_params
			params.permit!
		end

		def find_resource
			scoped_collection.friendly.find( params[ :id ] )
		end
	end
end
