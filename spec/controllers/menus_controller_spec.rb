require 'spec_helper'

RSpec.configure do |config|
	config.render_views = true
end

describe MenusController do
	describe "GET 'index'" do
		it "returns 404 on not json request" do
			get :index, format: :html

			expect( response.status ).to eq( 404 )
		end

		it "returns success response on json request" do
			get :index, format: :json

			expect( response.status ).to eq( 200 )
		end

		it "returns empty list without menu items" do
			get :index, format: :json

			expect( response.body ).to eq( [].to_json )
		end

		it "returns menu items if any created" do
			expected_json = [
				{
					id: 1,
					title: "Home",
					url: "/",
					parent_id: nil,
					position: 0
				},
				{
					id: 2,
					title: "About",
					url: "about",
					parent_id: 1,
					position: 0
				}
			].to_json

			MenuItem.create(
				title: "Home",
				url: "/",
				position: 0,
				parent_id: nil
			)

			MenuItem.create(
				title: "About",
				url: "about",
				position: 0,
				parent_id: 1
			)

			get :index, format: :json

			expect( response.body ).to eq( expected_json )
		end
	end

end
