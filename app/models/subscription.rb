class Subscription
  include Mongoid::Document
  include Mongoid::Timestamps
  include Resourceable

  field :application_id, type: Moped::BSON::ObjectId
  field :resources,      type: Array, default: []
  field :events,         type: Array, default: []
  field :redirect_uri

  index({ resource_owner_id: 1 })
  index({ application_id: 1 })

  attr_protected :application_id

  validates :application_id, presence: true
  validates :resources, presence: true, list: { in: Settings.subscriptions.resources }
  validates :events, presence: true, list: { in: Settings.subscriptions.events }
  validates :redirect_uri, uri: true
end
