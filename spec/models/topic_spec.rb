require 'rails_helper'

RSpec.describe Topic, :type => :model do
  it 'has a valid factory' do 
    FactoryGirl.create(:topic).should be_valid
  end
  it 'is invalid without a title' do 
    FactoryGirl.build(:topic, title: nil).should_not be_valid
  end
  it 'is invalid without a description' do 
    FactoryGirl.build(:topic, description: nil).should_not be_valid
  end
end
