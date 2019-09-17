require 'rails_helper'

RSpec.describe "podcasts/index", type: :view do
  before(:each) do
    assign(:podcasts, [
      Podcast.create!(
        :name => "Name"
      ),
      Podcast.create!(
        :name => "Name"
      )
    ])
  end

  it "renders a list of podcasts" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
