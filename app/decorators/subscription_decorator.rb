class SubscriptionDecorator < ApplicationDecorator
  decorates :subscription

  def uri
    h.subscription_path(model, default_options)
  end

  def application_uri
    "#{h.request.protocol}#{people_host}/oauth/applications/#{model.client_id}"
  end
end
