require 'rails_helper'

RSpec.describe "racers/show", type: :view do
  before(:each) do
    @racer = assign(:racer, Racer.create!(
      :first_name => "First Name",
      :last_name => "Last Name",
      :year_of_birth => 2,
      :gender => 3,
      :email => "Email",
      :phone_number => "Phone Number",
      :start_number => 4
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/First Name/)
    expect(rendered).to match(/Last Name/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Phone Number/)
    expect(rendered).to match(/4/)
  end
end
