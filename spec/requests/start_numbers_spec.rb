require 'rails_helper'

RSpec.describe "StartNumbers", type: :request do
  describe "GET /start_numbers" do
    it "works! (now write some real specs)" do
      get start_numbers_path
      expect(response).to have_http_status(200)
    end
  end
end
