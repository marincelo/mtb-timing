require "rails_helper"

RSpec.describe StartNumbersController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/start_numbers").to route_to("start_numbers#index")
    end

    it "routes to #new" do
      expect(:get => "/start_numbers/new").to route_to("start_numbers#new")
    end

    it "routes to #show" do
      expect(:get => "/start_numbers/1").to route_to("start_numbers#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/start_numbers/1/edit").to route_to("start_numbers#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/start_numbers").to route_to("start_numbers#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/start_numbers/1").to route_to("start_numbers#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/start_numbers/1").to route_to("start_numbers#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/start_numbers/1").to route_to("start_numbers#destroy", :id => "1")
    end

  end
end
