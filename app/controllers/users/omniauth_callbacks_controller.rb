class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def callback social
    service = Service.where(provider: auth.provider, uid: auth.uid).first

    # Look up existing user or create a new user with this facebook account
    if service.present?
      user = service.user
      service.update(
        expires_at: Time.at(auth.credentials.expires_at),
        access_token: auth.credentials.token
      )
    else
      user = User.create(
        email: auth.info.email,
        name: auth.info.name,
        password: Devise.friendly_token[0, 20]
      )
      user.services.create(
        provider: auth.provider,
        uid: auth.uid,
        expires_at: Time.at(auth.credentials.expires_at),
        access_token: auth.credentials.token
      )
    end

    sign_in_and_redirect user, event: :authentication
    set_flash_message :notice, :success, kind: "#{social.capitalize}"
  end

  def auth
    request.env["omniauth.auth"]
  end

  def facebook
    callback "facebook"
  end

  def google_oauth2
    callback "google_oauth2"
  end

end
