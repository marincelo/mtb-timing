require 'rails_helper'

RSpec.describe "start_numbers/edit", type: :view do
  before(:each) do
    @start_number = assign(:start_number, StartNumber.create!(
      :value => 1,
      :tag_id => "MyString",
      :signal_strength => 1,
      :racer => nil
    ))
  end

  it "renders the edit start_number form" do
    render

    assert_select "form[action=?][method=?]", start_number_path(@start_number), "post" do

      assert_select "input#start_number_value[name=?]", "start_number[value]"

      assert_select "input#start_number_tag_id[name=?]", "start_number[tag_id]"

      assert_select "input#start_number_signal_strength[name=?]", "start_number[signal_strength]"

      assert_select "input#start_number_racer_id[name=?]", "start_number[racer_id]"
    end
  end
end
