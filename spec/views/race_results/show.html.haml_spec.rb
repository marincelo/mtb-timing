require 'rails_helper'

RSpec.describe "race_results/show", type: :view do
  before(:each) do
    @race_result = assign(:race_result, RaceResult.create!(
      :racer => nil,
      :race => nil,
      :status => 2,
      :lap_times => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/MyText/)
  end
end
