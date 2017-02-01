require 'rails_helper'

describe 'links page' do
  it 'has search field' do
    visit '/links'
    expect(page).to have_field(id: 'search')
  end
end