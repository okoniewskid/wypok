require 'rails_helper'

describe 'home page' do
  it 'has logo' do
    visit '/'
    has_text?('logo')
  end
end