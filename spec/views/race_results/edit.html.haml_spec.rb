require 'rails_helper'

RSpec.describe "race_results/edit", type: :view do
  before(:each) do
    @race_result = assign(:race_result, RaceResult.create!(
      :racer => nil,
      :race => nil,
      :status => 1,
      :lap_times => "MyText"
    ))
  end

  it "renders the edit race_result form" do
    render

    assert_select "form[action=?][method=?]", race_result_path(@race_result), "post" do

      assert_select "input#race_result_racer_id[name=?]", "race_result[racer_id]"

      assert_select "input#race_result_race_id[name=?]", "race_result[race_id]"

      assert_select "input#race_result_status[name=?]", "race_result[status]"

      assert_select "textarea#race_result_lap_times[name=?]", "race_result[lap_times]"
    end
  end
end
