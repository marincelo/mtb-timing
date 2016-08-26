require 'rails_helper'

RSpec.describe "RaceResults", type: :request do
  describe "GET /race_results" do
    it "works! (now write some real specs)" do
      get race_results_path
      expect(response).to have_http_status(200)
    end
  end
end
