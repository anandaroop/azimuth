require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe "GET 'index'" do
    context 'anonymous user' do
      it 'redirects to gravity' do
        get :index
        expect(response.status).to be 302
        expect(response).to redirect_to('/auth/artsy')
      end
    end

    context 'logged in non-admin user' do
      include_context 'logged-in user'
      it 'redirects to Artsy URL' do
        get :index
        expect(response.status).to be 302
        expect(response).to redirect_to(Kinetic.config[:artsy_url])
      end
    end

    context 'logged in admin user' do
      include_context 'logged-in admin'
      it 'renders the index template' do
        get :index
        expect(response.status).to be 200
        expect(response).to render_template('index')
      end
    end
  end
end
