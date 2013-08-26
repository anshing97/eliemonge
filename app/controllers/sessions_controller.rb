class SessionsController < ApplicationController

  def create
    auth = request.env["omniauth.auth"]
    auth.to_yaml
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    user.update_credentials(auth)
    session[:user_id] = user.id
    session[:user_token] = user.token 
    session[:user_secret] = user.secret 
    redirect_to root_url, :notice => "Signed in!"
  end

  def destroy
    session[:user_id] = nil
    session[:user_token] = nil
    session[:user_secret] = nil     
    redirect_to root_url, :notice => "Signed out!"
  end

end