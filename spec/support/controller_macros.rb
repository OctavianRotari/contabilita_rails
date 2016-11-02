module ControllerMacros
  def sign_in_user
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      user = create(:user)
      sign_in user
    end
  end
end
