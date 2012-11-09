class Subscription
  include Mongoid::Document
  include Mongoid::Timestamps
  include Resourceable

  field :client_id, type: Moped::BSON::ObjectId
  field :resource
  field :event
  field :callback_uri

  index({ resource_owner_id: 1 })
  index({ client_id: 1, resource: 1, event: 1 })

  attr_protected :client_id

  validates :client_id, presence: true
  validates :resource, presence: true, inclusion: { in: Settings.subscriptions.resources }
  validates :event, presence: true, inclusion: { in: Settings.subscriptions.events }
  validates :callback_uri, uri: true
end
