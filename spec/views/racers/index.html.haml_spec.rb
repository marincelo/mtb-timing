require 'rails_helper'

RSpec.describe "racers/index", type: :view do
  before(:each) do
    assign(:racers, [
      Racer.create!(
        :first_name => "First Name",
        :last_name => "Last Name",
        :year_of_birth => 2,
        :gender => 3,
        :email => "Email",
        :phone_number => "Phone Number",
        :start_number => 4
      ),
      Racer.create!(
        :first_name => "First Name",
        :last_name => "Last Name",
        :year_of_birth => 2,
        :gender => 3,
        :email => "Email",
        :phone_number => "Phone Number",
        :start_number => 4
      )
    ])
  end

  it "renders a list of racers" do
    render
    assert_select "tr>td", :text => "First Name".to_s, :count => 2
    assert_select "tr>td", :text => "Last Name".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Phone Number".to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
  end
end
