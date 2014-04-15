require "jbuilder"

class MenusController < ApplicationController
	before_filter :check_format

	def index
		@menus = MenuItem.all
	end

	private

		def check_format
			render nothing: true, status: 404 unless params[ :format ] == "json"
		end
end
