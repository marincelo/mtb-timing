require 'rails_helper'

RSpec.describe "races/index", type: :view do
  before(:each) do
    assign(:races, [
      Race.create!(
        :name => "Name",
        :laps => 2,
        :easy_laps => 3
      ),
      Race.create!(
        :name => "Name",
        :laps => 2,
        :easy_laps => 3
      )
    ])
  end

  it "renders a list of races" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
