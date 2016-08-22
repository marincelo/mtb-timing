require "rails_helper"

RSpec.describe RacersController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/racers").to route_to("racers#index")
    end

    it "routes to #new" do
      expect(:get => "/racers/new").to route_to("racers#new")
    end

    it "routes to #show" do
      expect(:get => "/racers/1").to route_to("racers#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/racers/1/edit").to route_to("racers#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/racers").to route_to("racers#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/racers/1").to route_to("racers#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/racers/1").to route_to("racers#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/racers/1").to route_to("racers#destroy", :id => "1")
    end

  end
end
