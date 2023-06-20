require 'rails_helper'

RSpec.describe 'Movies' do
  describe 'GET /' do
    before do
      get '/'
    end

    it 'responds with ok status' do
      expect(response).to have_http_status(:ok)
    end

    it 'contains a results key' do
      expect(response.parsed_body).to have_key('results')
    end

    it 'contains at least one movie' do
      expect(response.parsed_body['results']).not_to be_empty
    end
  end
end
