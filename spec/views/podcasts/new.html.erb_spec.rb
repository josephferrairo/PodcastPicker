require 'rails_helper'

RSpec.describe "podcasts/new", type: :view do
  before(:each) do
    assign(:podcast, Podcast.new(
      :name => "MyString"
    ))
  end

  it "renders new podcast form" do
    render

    assert_select "form[action=?][method=?]", podcasts_path, "post" do

      assert_select "input[name=?]", "podcast[name]"
    end
  end
end
