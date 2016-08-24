def login_as(current_user)
  access_token = '4, 8, 15, 16, 23, 42'
  Kinetic::Stub::Gravity::Me.identify(current_user)
  page.set_rack_session(access_token: access_token)
  session[:access_token] = access_token
end

shared_context 'logged-in user' do
  before do
    login_as user
  end
  let(:user) { Fabricate(:kinetic_user) }
end

shared_context 'logged-in admin' do
  before do
    login_as admin
  end
  let(:admin) { Fabricate(:kinetic_admin) }
end
