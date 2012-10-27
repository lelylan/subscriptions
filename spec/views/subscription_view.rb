module HelpersViewMethods
  def has_subscription(subscription, json = nil)
    json.uri.should == subscription.uri
    json.id.should  == subscription.id.as_json
    json.application_uri.should == subscription.application_uri
    json.resources.should == subscription.resources
    json.events.should == subscription.events
    json.callback_uri.should == subscription.callback_uri
    json.created_at.should_not be_nil
    json.updated_at.should_not be_nil
  end
end

RSpec.configuration.include HelpersViewMethods
