require 'rails_helper'

RSpec.describe "race_results/new", type: :view do
  before(:each) do
    assign(:race_result, RaceResult.new(
      :racer => nil,
      :race => nil,
      :status => 1,
      :lap_times => "MyText"
    ))
  end

  it "renders new race_result form" do
    render

    assert_select "form[action=?][method=?]", race_results_path, "post" do

      assert_select "input#race_result_racer_id[name=?]", "race_result[racer_id]"

      assert_select "input#race_result_race_id[name=?]", "race_result[race_id]"

      assert_select "input#race_result_status[name=?]", "race_result[status]"

      assert_select "textarea#race_result_lap_times[name=?]", "race_result[lap_times]"
    end
  end
end
