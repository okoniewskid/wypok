require 'rails_helper'

RSpec.describe Link, :type => :model do
    before(:each) do
        subject { described_class.new }
        subject.title = 'This is a link'
        subject.url = 'http://www.google.pl/'
    end
    
    it 'should be valid with valid attributes' do
        expect(subject).to be_valid
    end
    
    it 'should not be valid without a title' do
        subject.title = nil
        expect(subject).not_to be_valid
    end
    
    context 'validates url' do
        it 'should not be valid without url' do
            subject.url = nil
            expect(subject).not_to be_valid
        end
        
        it 'should begin with protocol' do
           subject.url = 'www.google.pl'
           expect(subject).not_to be_valid
        end
        
        it 'should have domain name and extension' do
           subject.url = 'http://google' 
           expect(subject).not_to be_valid
        end
    end
end