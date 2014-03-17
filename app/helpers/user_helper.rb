module UserHelper

  def user_access_token 
    
    def prepare_access_token(oauth_token, oauth_token_secret)
      consumer = OAuth::Consumer.new("BCvgSeawxoZCPYqThnPV", "FxEPTHDkhtqGoZGHhrQDojwgyPIEhLGm", { :site => "http://api.discogs.com/" })
      # now create the access token object from passed values
      token_hash = { :oauth_token => oauth_token,
                     :oauth_token_secret => oauth_token_secret }

      access_token = OAuth::AccessToken.from_hash(consumer, token_hash )
      return access_token
    end

    # Exchange our oauth_token and oauth_token secret for the AccessToken instance.
    @access_token ||= prepare_access_token(current_user.token,current_user.secret)

  end 
end
