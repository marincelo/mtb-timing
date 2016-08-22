require 'rails_helper'

RSpec.describe "races/new", type: :view do
  before(:each) do
    assign(:race, Race.new(
      :name => "MyString",
      :laps => 1,
      :easy_laps => 1
    ))
  end

  it "renders new race form" do
    render

    assert_select "form[action=?][method=?]", races_path, "post" do

      assert_select "input#race_name[name=?]", "race[name]"

      assert_select "input#race_laps[name=?]", "race[laps]"

      assert_select "input#race_easy_laps[name=?]", "race[easy_laps]"
    end
  end
end
