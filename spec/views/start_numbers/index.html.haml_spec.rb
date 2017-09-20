require 'rails_helper'

RSpec.describe "start_numbers/index", type: :view do
  before(:each) do
    assign(:start_numbers, [
      StartNumber.create!(
        :value => 2,
        :tag_id => "Tag",
        :signal_strength => 3,
        :racer => nil
      ),
      StartNumber.create!(
        :value => 2,
        :tag_id => "Tag",
        :signal_strength => 3,
        :racer => nil
      )
    ])
  end

  it "renders a list of start_numbers" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Tag".to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
