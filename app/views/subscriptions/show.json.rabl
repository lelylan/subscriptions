object SubscriptionDecorator.decorate(@subscription)

node(:uri)          { |s| s.uri }
node(:id)           { |s| s.id }
node(:client)       { |s| { uri: s.client_uri } }
node(:resource)     { |s| s.resource }
node(:event)        { |s| s.event }
node(:callback_uri) { |s| s.callback_uri }
node(:created_at)   { |s| s.created_at }
node(:updated_at)   { |s| s.updated_at }
