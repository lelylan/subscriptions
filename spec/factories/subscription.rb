Settings.add_source!("#{Rails.root}/config/settings/test.yml")
Settings.reload!

FactoryGirl.define do
  factory :subscription do
    client_id { FactoryGirl.create(:application).id }
    resources %w(status)
    events %w(update)
    callback_uri 'http://callback.com/lelylan'
  end

  trait :with_all_subs do
    after(:create) do |floor|
      subs.update_attributes resources: %w(device type location), events: %w(create update delete execute)
    end
  end
end
