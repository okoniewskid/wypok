require 'rails_helper'

RSpec.describe "links/index", type: :view do
  before(:each) do
    assign(:links, [
      Link.create!(),
      Link.create!()
    ])
  end

  it "renders a list of links" do
    render
  end
end
