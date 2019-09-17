require 'rails_helper'

RSpec.describe "podcasts/show", type: :view do
  before(:each) do
    @podcast = assign(:podcast, Podcast.create!(
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
