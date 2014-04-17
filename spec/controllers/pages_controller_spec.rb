require 'spec_helper'

RSpec.configure do |config|
	config.render_views = true
end

describe PagesController do
	let( :custom_properties ) { { "key" => "value" } }

	describe "GET 'index'" do
		it "returns 404 on not json request" do
			get :index, format: :html

			expect( response.status ).to eq( 404 )
		end

		it "returns empty array without pages" do
			get :index, format: :json

			expect( response.status ).to eq( 200 )
		end

		it "returns pages if any created" do
			expected_json = [
				{
					id: 1,
					title: "Home",
					slug: "home",
					template: "home",
					position: 0,
					properties: custom_properties.to_json
				},
				{
					id: 2,
					title: "About",
					slug: "about",
					template: "about",
					position: 0,
					properties: custom_properties.to_json
				}
			].to_json

			Page.create(
				title: "Home",
				template: "home",
				properties: custom_properties
			)

			Page.create(
				title: "about",
				template: "about",
				properties: custom_properties
			)

			get :index, format: :json

			expect( response.body ).to eq( expect_json )
		end
	end

	describe "GET 'show'" do
		it "returns 404 on not json request" do
			get :index, format: :html

			expect( response.status ).to eq( 404 )
		end

		it "returns 404 if page is not found" do
			get :show, id: 2, format: :json

			expect( response.status ).to eq( 404 )
		end

		it "returns page if found" do
			expected_json = {
				id: 1,
				title: "Home",
				slug: "home",
				template: "home",
				position: 0,
				properties: custom_properties.to_json
			}.to_json

			Page.create(
				title: "Home",
				template: "home",
				properties: custom_properties
			);

			get :show, id: 1, format: :json

			expect( response.body ).to eq( expected_json )
		end
	end

end
