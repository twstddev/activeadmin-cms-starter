class JsonController < ApplicationController
	before_filter :check_format

	private

		def check_format
			render nothing: true, status: 404 unless params[ :format ] == "json"
		end
end
