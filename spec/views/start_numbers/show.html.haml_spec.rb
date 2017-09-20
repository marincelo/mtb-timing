require 'rails_helper'

RSpec.describe "start_numbers/show", type: :view do
  before(:each) do
    @start_number = assign(:start_number, StartNumber.create!(
      :value => 2,
      :tag_id => "Tag",
      :signal_strength => 3,
      :racer => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Tag/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(//)
  end
end
