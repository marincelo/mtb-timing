require 'rails_helper'

RSpec.describe "races/show", type: :view do
  before(:each) do
    @race = assign(:race, Race.create!(
      :name => "Name",
      :laps => 2,
      :easy_laps => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
  end
end
