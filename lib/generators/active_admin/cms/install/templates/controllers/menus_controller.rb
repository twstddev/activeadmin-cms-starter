class MenusController < JsonController
	def index
		@menus = MenuItem.all
	end
end
