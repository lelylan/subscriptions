shared_examples_for 'a not authorized resource' do |action|
  context 'when not logged in' do

    it 'is not authorized' do
      eval(action)
      has_valid_json
      has_unauthorized_resource
    end
  end
end
