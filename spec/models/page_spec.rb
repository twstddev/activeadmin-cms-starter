require 'spec_helper'

describe Page do
	let( :custom_properties ) { { "content" => "custom text" } }
	before :each do
		Page.stub( :templates ).and_return( {
			"Home" => "home"
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

	it "saves properties" do
		@page.save

		expect( @page.properties ).to eq( custom_properties )
	end

	it "sets a default value to properties" do
		@page.properties = ""
		save_result = @page.save

		expect( @page.properties ).to be_a( Hash )
	end

	it "validates template existence" do
		@page.template = "about"
		@page.save

		expect( @page ).to have( 1 ).error_on( :template )
	end
end
