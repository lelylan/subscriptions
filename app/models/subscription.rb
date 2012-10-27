class Subscription
  include Mongoid::Document
  include Mongoid::Timestamps
  include Resourceable

  field :client_id, type: Moped::BSON::ObjectId
  field :resources, type: Array, default: []
  field :events,    type: Array, default: []
  field :callback_uri

  index({ resource_owner_id: 1 })
  index({ client_id: 1 })

  attr_protected :client_id

  validates :client_id, presence: true
  validates :resources, presence: true, list: { in: Settings.subscriptions.resources }
  validates :events, presence: true, list: { in: Settings.subscriptions.events }
  validates :callback_uri, uri: true
end
