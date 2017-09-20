require 'rails_helper'

RSpec.describe "start_numbers/new", type: :view do
  before(:each) do
    assign(:start_number, StartNumber.new(
      :value => 1,
      :tag_id => "MyString",
      :signal_strength => 1,
      :racer => nil
    ))
  end

  it "renders new start_number form" do
    render

    assert_select "form[action=?][method=?]", start_numbers_path, "post" do

      assert_select "input#start_number_value[name=?]", "start_number[value]"

      assert_select "input#start_number_tag_id[name=?]", "start_number[tag_id]"

      assert_select "input#start_number_signal_strength[name=?]", "start_number[signal_strength]"

      assert_select "input#start_number_racer_id[name=?]", "start_number[racer_id]"
    end
  end
end
