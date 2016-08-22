require 'rails_helper'

RSpec.describe "races/edit", type: :view do
  before(:each) do
    @race = assign(:race, Race.create!(
      :name => "MyString",
      :laps => 1,
      :easy_laps => 1
    ))
  end

  it "renders the edit race form" do
    render

    assert_select "form[action=?][method=?]", race_path(@race), "post" do

      assert_select "input#race_name[name=?]", "race[name]"

      assert_select "input#race_laps[name=?]", "race[laps]"

      assert_select "input#race_easy_laps[name=?]", "race[easy_laps]"
    end
  end
end
