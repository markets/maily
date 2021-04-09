RSpec.describe Maily::EmailsController, type: :controller do
  render_views

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
      get :show, params: { mailer: 'notifier', email: 'non_existent_email' }

      expect(response.status).to eq(302)
      expect(flash.alert).to eq("Email not found!")
    end

    it 'hidden emails -> 302' do
      get :show, params: { mailer: 'notifier', email: 'hidden' }

      expect(response.status).to eq(302)
      expect(flash.alert).to eq("Email not found!")
    end
  end

  describe 'GET #raw' do
    it 'renders the template (HTML part)' do
      get :raw, params: { mailer: 'notifier', email: 'with_arguments' }

      expect(response.body).to match("<h1>With arguments</h1>")
    end

    it 'renders the template (TEXT part)' do
      get :raw, params: { mailer: 'notifier', email: 'only_text' }

      expect(response.body).to match("<p>Text part\n<br />with break lines</p>")
    end

    it 'renders inline attachments' do
      get :raw, params: { mailer: 'notifier', email: 'with_inline_attachments' }

      expect(response.body).to match("data:image/jpeg;base64")
    end
  end
end
