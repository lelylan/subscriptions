Settings.add_source!("#{Rails.root}/config/settings/test.yml")
Settings.reload!

FactoryGirl.define do
  factory :subscription do
    client_id { FactoryGirl.create(:application).id }
    resource 'devices'
    event 'property-update'
    callback_uri 'http://callback.com/lelylan'
  end
end
