class SubscriptionSerializer < ApplicationSerializer
  cached true

  attributes :uri, :id, :client, :resource, :event, :callback_uri, :created_at, :updated_at

  def uri
    SubscriptionDecorator.decorate(object).uri
  end

  def client
    { uri: SubscriptionDecorator.decorate(object).client_uri }
  end
end
