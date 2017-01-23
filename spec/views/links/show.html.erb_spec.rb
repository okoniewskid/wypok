require 'rails_helper'

RSpec.describe "links/show", type: :view do
  before(:each) do
    @link = assign(:link, Link.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
