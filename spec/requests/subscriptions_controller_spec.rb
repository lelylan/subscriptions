require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature 'SubscriptionsController' do

  let!(:application)  { FactoryGirl.create :application }

  before { page.driver.browser.authorize application.uid, application.secret }
  before { page.driver.header 'Content-Type', 'application/json' }

  let(:controller) { 'subscriptions' }
  let(:factory)    { 'subscription' }

  describe 'GET /subscriptions' do

    let!(:resource) { FactoryGirl.create :subscription, client_id: application.id }
    let(:uri)       { '/subscriptions' }

    it_behaves_like 'a listable resource'
    it_behaves_like 'a paginable resource'
    it_behaves_like 'a searchable resource', { resource: 'consumptions', event: 'delete' }
  end

  context 'GET /subscriptions/:id' do

    let!(:resource) { FactoryGirl.create :subscription, client_id: application.id }
    let(:uri)       { "/subscriptions/#{resource.id}" }

    it_behaves_like 'a showable resource'
    it_behaves_like 'a proxiable resource'
    it_behaves_like 'a crossable resource'
    it_behaves_like 'a not owned resource', 'page.driver.get(uri)'
    it_behaves_like 'a not found resource', 'page.driver.get(uri)'
  end

  context 'POST /subscriptions' do

    let(:uri) { '/subscriptions' }

    let(:params) {{
      resource:     'devices',
      event:       'property-update',
      callback_uri: 'http://callback.com/lelylan'
    }}

    it_behaves_like 'a creatable resource'
    it_behaves_like 'a validated resource', 'page.driver.post(uri, {}.to_json)', { method: 'POST', error: "can't be blank" }
  end

  context 'PUT /subscriptions/:id' do

    let!(:resource)  { FactoryGirl.create :subscription, client_id: application.id }

    let(:uri) { "/subscriptions/#{resource.id}" }

    let(:params) {{
      resource:     'locations',
      event:        'delete',
      callback_uri: 'http://callback.com/update'
    }}

    it_behaves_like 'an updatable resource', 'locations'
    it_behaves_like 'an updatable resource', 'delete'
    it_behaves_like 'an updatable resource', 'http://callback.com/update'

    it_behaves_like 'a not owned resource', 'page.driver.put(uri)'
    it_behaves_like 'a not found resource', 'page.driver.put(uri)'
    it_behaves_like 'a validated resource', 'page.driver.put(uri, { resource: "" }.to_json)', { method: 'PUT', error: "can't be blank" }
  end

  context 'DELETE /subscriptions/:id' do
    let!(:resource)  { FactoryGirl.create :subscription, client_id: application.id }
    let(:uri)        { "/subscriptions/#{resource.id}" }

    it_behaves_like 'a deletable resource'
    it_behaves_like 'a not owned resource', 'page.driver.delete(uri)'
    it_behaves_like 'a not found resource', 'page.driver.delete(uri)'
  end

  context 'with not valid credentials' do

    before { page.driver.browser.authorize 'not_exisitng_app_uid', application.secret }

    describe 'GET /subscriptions' do
      let(:uri) { '/subscriptions' }
      it_behaves_like 'a not authorized resource', 'page.driver.get(uri)'
    end
  end
end

