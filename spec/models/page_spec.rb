require 'spec_helper'

describe Page do
	let( :custom_properties ) { "{ \"content\": \"custom text\" }" }
	before :each do
		Page.stub( :templates ).and_return( {
			"home" => "Home"
		} )

		@page = Page.new(
			title: "My first page",
			slug: "my-first-page",
			properties: custom_properties
		)
	end

	it "requires title" do
		@page.title = ""
		@page.save

		expect( @page ).to have( 1 ).error_on( :title )
	end

	it "requires slug" do
		@page.slug = ""
		@page.save

		expect( @page ).to have( 1 ).error_on( :slug )
	end

	it "slug is unique" do
		Page.create(
			title: "test page",
			slug: "my-first-page"
		)

		expect( @page ).to have( 1 ).error_on( :slug )
	end

	it "generates slug from title" do
		@page.title = "another title"
		@page.slug = nil
		@page.save

		expect( @page.slug ).to eq( "another-title" )
	end

	it "validates template existence" do
		@page.template = "about"
		@page.save

		expect( @page ).to have( 1 ).error_on( :template )
	end
end
