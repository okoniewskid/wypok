require 'rails_helper'

RSpec.describe Comment, :type => :model do
    before(:each) do
        subject { described_class.new }
        subject.link_id = '1'
        subject.body = 'This is a comment'
    end
    
    it 'should be valid with valid attributes' do
        expect(subject).to be_valid
    end
    
    it 'should be connected to link' do
        subject.link_id = nil
        expect(subject).not_to be_valid
    end
    
    it 'should have body' do
        subject.body = nil
        expect(subject).not_to be_valid
    end
end