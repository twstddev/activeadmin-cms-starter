require "spec_helper"

describe MenuItem do
	before :each do
		@menu_item = MenuItem.new(
			title: "Home",
			url: "/"
		)
	end

	it "should have title" do
		expect( @menu_item.title ).to eq( "Home" )
	end

	it "should have url" do
		expect( @menu_item.url ).to eq( "/" )
	end

	it "should have parent" do
		@menu_item.save
		@menu_item.children.create( 
			title: "Subitem",
			url: "/sub"
		)

		expect( @menu_item.children.first.parent_id ).to eq( @menu_item.id )
	end

	it "fails validation without title" do
		@menu_item.title = ""
		@menu_item.save

		expect( @menu_item ).to have( 1 ).error_on( :title )
	end

	it "fails validation without url" do
		@menu_item.url = ""
		@menu_item.save

		expect( @menu_item ).to have( 1 ).error_on( :url )
	end
end
