require 'spec_helper'

describe Subscription do

  it { should validate_presence_of 'client_id'  }
  it { should validate_presence_of 'resource' }
  it { should validate_presence_of 'event' }

  it { Settings.uris.valid.each     { |uri| should allow_value(uri).for(:callback_uri) } }
  it { Settings.uris.not_valid.each { |uri| should_not allow_value(uri).for(:callback_uri) } }

  it { Settings.subscriptions.resources.each { |resource| should allow_value(resource).for(:resource) } }
  it { Settings.subscriptions.events.each    { |event| should allow_value(event).for(:event) } }

  describe 'when a subscription is created' do

    let!(:client_id)    { FactoryGirl.create(:application).id }
    let!(:subscription) { FactoryGirl.create :subscription, client_id: client_id }

    it 'does not create a duplicated subscription' do
      expect {
        FactoryGirl.create(:subscription, client_id: client_id)
      }.to raise_error(Mongoid::Errors::Validations, /Client already created the desired subscription/)
    end

    it 'creates a new subscription to a different URI' do
      expect {
        FactoryGirl.create(:subscription, client_id: client_id, callback_uri: "http://callback.com/#{SecureRandom.uuid}")
      }.to_not raise_error
    end
  end
end
