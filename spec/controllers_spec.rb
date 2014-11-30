require 'spec_helper'

describe Maily::EmailsController, type: :controller do
  routes { Maily::Engine.routes }

  before(:each) do
    Maily.init!
  end

  it 'responds ok if enabled' do
    expect { get :index }.not_to raise_error
  end

  it 'raise error if disabled' do
    Maily.enabled = false
    expect { get :index }.to raise_error('Maily: engine disabled!')
  end

  it 'responds with 401 if http authorization fails' do
    Maily.http_authorization = { username: 'admin', password: 'admin' }
    get :index
    expect(response.status).to eq(401)
  end

  it 'responds ok with valid http authorization' do
    Maily.http_authorization = { username: 'admin', password: 'admin' }
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials('admin', 'admin')
    get :index
    expect(response.status).to eq(200)
  end
end