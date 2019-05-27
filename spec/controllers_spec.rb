RSpec.describe Maily::EmailsController, type: :controller do
  render_views

  # Rails 4 compatibility
  def compatible_get(action, **params)
    if ::Rails::VERSION::STRING > '5'
      get action, params: params
    else
      get action, params
    end
  end

  routes { Maily::Engine.routes }

  before(:each) do
    Maily.init!
  end

  it 'responds ok if enabled' do
    expect { get :index }.not_to raise_error
  end

  it 'raises 404 if disabled' do
    Maily.enabled = false

    get :index

    expect(response.status).to eq(404)
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

  describe 'non-existent emails' do
    it 'email not in the system -> 302' do
      compatible_get :show, mailer: 'notifier', email: 'non_existent_email'

      expect(response.status).to eq(302)
      expect(flash.alert).to eq("Email not found!")
    end

    it 'hidden emails -> 302' do
      compatible_get :show, mailer: 'notifier', email: 'hidden'

      expect(response.status).to eq(302)
      expect(flash.alert).to eq("Email not found!")
    end
  end

  describe 'GET #raw' do
    it 'renders the template (HTML part)' do
      compatible_get :raw, mailer: 'notifier', email: 'invitation'

      expect(response.body).to match("<h1>Invitation</h1>")
    end

    it 'renders the template (TEXT part)' do
      compatible_get :raw, mailer: 'notifier', email: 'only_text'

      expect(response.body).to match("<p>Text part\n<br />with break lines</p>")
    end
  end
end