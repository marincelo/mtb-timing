require 'rails_helper'

RSpec.describe "race_results/index", type: :view do
  before(:each) do
    assign(:race_results, [
      RaceResult.create!(
        :racer => nil,
        :race => nil,
        :status => 2,
        :lap_times => "MyText"
      ),
      RaceResult.create!(
        :racer => nil,
        :race => nil,
        :status => 2,
        :lap_times => "MyText"
      )
    ])
  end

  it "renders a list of race_results" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
