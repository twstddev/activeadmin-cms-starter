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
					position: nil,
					properties: custom_properties
				},
				{
					id: 2,
					title: "About",
					slug: "about",
					template: "about",
					position: nil,
					properties: custom_properties
				}
			].to_json

			Page.create(
				title: "Home",
				template: "home",
				properties: custom_properties,
			)

			Page.create(
				title: "About",
				template: "about",
				properties: custom_properties
			)

			get :index, format: :json

			expect( response.body ).to eq( expected_json )
		end
	end

	describe "GET 'show'" do
		it "returns 404 on not json request" do
			get :index, format: :html

			expect( response.status ).to eq( 404 )
		end

		it "returns 404 if page is not found" do
			get :show, id: "non-existing", format: :json

			expect( response.status ).to eq( 404 )
		end

		it "returns page if found" do
			expected_json = {
				id: 1,
				title: "Another page",
				slug: "another-page",
				template: "home",
				position: nil,
				properties: custom_properties
			}.to_json

			Page.create(
				title: "Another page",
				template: "home",
				properties: custom_properties
			);

			get :show, id: "another-page", format: :json

			expect( response.body ).to eq( expected_json )
		end
	end

end
