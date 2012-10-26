require 'spec_helper'

describe Subscription do

  subject { FactoryGirl.create :subscription }

  it { should validate_presence_of('application_id') }
  it { should validate_presence_of('resources') }
  it { should validate_presence_of('events') }

  it { Settings.uris.valid.each     { |uri| should allow_value(uri).for(:redirect_uri) } }
  it { Settings.uris.not_valid.each { |uri| should_not allow_value(uri).for(:redirect_uri) } }


  context 'when validating the resource types' do

    %w(device type location).each do |resource|

      context 'with valid resources' do

        let(:subscription) { FactoryGirl.create(:subscription, resources: [resource]) }

        it "allows #{resource} as resource type" do
          subscription.resources.should == [resource]
        end
      end
    end

    [nil, '', 'not_valid'].each do |resource|

      context 'with not valid resources' do

        let(:subscription) { FactoryGirl.create(:subscription, resources: [resource]) }

        it "raises a validation error for #{resource}" do
          expect { subscription }.to raise_error(Mongoid::Errors::Validations)
        end
      end
    end
  end

  
  context 'when validating the event types' do

    %w(create update delete execute).each do |event|

      context 'with valid events' do

        let(:subscription) { FactoryGirl.create(:subscription, events: [event]) }

        it "allows #{event} as resource type" do
          subscription.events.should == [event]
        end
      end
    end

    [nil, '', 'not_valid'].each do |event|

      context 'with not valid event' do

        let(:subscription) { FactoryGirl.create(:subscription, events: [event]) }

        it "raises a validation error for #{event}" do
          expect { subscription }.to raise_error(Mongoid::Errors::Validations)
        end
      end
    end
  end
end
