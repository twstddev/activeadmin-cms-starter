class PagesController < JsonController

  def index
	  @pages = Page.all.order( :position )
  end

  def show
	  @page = Page.friendly.find( params[ :id ] )

	  rescue ActiveRecord::RecordNotFound => e
		  render nothing: true, status: 404
  end
end
