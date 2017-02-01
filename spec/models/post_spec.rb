require 'rails_helper'

RSpec.describe Post, type: :model do
  before(:each) do
        subject { described_class.new }
        subject.title = 'This is a post'
        subject.body = 'This is body of the post'
    end
    
    it 'should be valid with valid attributes' do
        expect(subject).to be_valid
    end
    
    it 'should not be valid without a title' do
        subject.title = nil
        expect(subject).not_to be_valid
    end
    
    it 'should not be valid without a body' do
        subject.body = nil
        expect(subject).not_to be_valid
    end
end
