require "spec_helper"

RSpec.configure do |config|
	config.render_views = true
end

describe BootstrapController do
	describe "GET 'index'" do
		it "returns 404 on not json request" do
			get :index, format: :html

			expect( response.status ).to eq( 404 )
		end

		it "returns success on JSON request" do
			get :index, format: :json

			expect( response.status ).to eq( 200 )
		end

		it "returns empty bootstrap" do
			expected_json = {
				menu_items: [],
				pages: []
			}.to_json

			get :index, format: :json

			expect( response.body ).to eq( expected_json )
		end
	end
end
