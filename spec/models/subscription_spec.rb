require 'spec_helper'

describe Subscription do

  subject { FactoryGirl.create :subscription }

  it { should validate_presence_of 'client_id'  }
  it { should validate_presence_of 'resource' }
  it { should validate_presence_of 'event' }

  it { Settings.uris.valid.each     { |uri| should allow_value(uri).for(:callback_uri) } }
  it { Settings.uris.not_valid.each { |uri| should_not allow_value(uri).for(:callback_uri) } }

  it { Settings.subscriptions.resources.each { |resource| should allow_value(resource).for(:resource) } }
  it { Settings.subscriptions.events.each    { |event| should allow_value(event).for(:event) } }
end
