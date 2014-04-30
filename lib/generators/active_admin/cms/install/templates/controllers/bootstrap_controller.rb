class BootstrapController < JsonController
	def index
		@menus = MenuItem.all
		@pages = Page.all.order( :position )
	end
end
