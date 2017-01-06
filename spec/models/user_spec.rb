require 'rails_helper'

RSpec.describe User, :type => :model do
    before(:each) do
        subject { described_class.new }
        subject.name = 'Daniel'
        subject.email = 'some@email.com'
        subject.password = 'password12'
    end
  
    it 'should be valid with valid attributes' do
        expect(subject).to be_valid
    end
    
    it 'should not be valid without a name' do
        subject.name = nil
        expect(subject).not_to be_valid
    end
    
    context 'validates email' do
        it 'should not be valid without an email' do
            subject.email = nil
            expect(subject).not_to be_valid
        end
        
        it 'should be correct format' do
            subject.email = '@mail.com'
            expect(subject).not_to be_valid
        end
    end
    
    context 'validates password' do
        it 'should not be valid without a password' do
            subject.password = nil
            expect(subject).not_to be_valid
        end
        
        it 'should not be valid with short password' do
            subject.password = 'pas12'
            expect(subject).not_to be_valid
        end
    end
end