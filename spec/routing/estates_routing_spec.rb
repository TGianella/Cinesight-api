require "rails_helper"

RSpec.describe EstatesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/estates").to route_to("estates#index")
    end

    it "routes to #show" do
      expect(get: "/estates/1").to route_to("estates#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/estates").to route_to("estates#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/estates/1").to route_to("estates#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/estates/1").to route_to("estates#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/estates/1").to route_to("estates#destroy", id: "1")
    end
  end
end
