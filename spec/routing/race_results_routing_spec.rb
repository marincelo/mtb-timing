require "rails_helper"

RSpec.describe RaceResultsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/race_results").to route_to("race_results#index")
    end

    it "routes to #new" do
      expect(:get => "/race_results/new").to route_to("race_results#new")
    end

    it "routes to #show" do
      expect(:get => "/race_results/1").to route_to("race_results#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/race_results/1/edit").to route_to("race_results#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/race_results").to route_to("race_results#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/race_results/1").to route_to("race_results#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/race_results/1").to route_to("race_results#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/race_results/1").to route_to("race_results#destroy", :id => "1")
    end

  end
end
