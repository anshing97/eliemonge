class UserController < ApplicationController

  def profile

    json = get_user_response get_folder('awesomeness')

    render :json => json
  end

  def folders
    json = get_user_response user_folders
    @data = json['folders']
  end 

  def folder
    json = get_user_response get_folder params[:folder]
    render :json => json
  end 

  private   
    def user_folders
      "/users/#{current_user.name}/collection/folders"
    end

    def get_folder ( folder )
      json = get_user_response user_folders
      folders = json['folders']
      match = folders.select { |e| e['name'] == folder }.first

      folder_url = match['resource_url']
      folder_url.slice!('http://api.discogs.com')
      folder_url + '/releases'
    end 

    def get_user_response (api_call)

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

      # use the access token as an agent to get the home timeline
      JSON.parse @access_token.get(api_call).body
    end 

end
