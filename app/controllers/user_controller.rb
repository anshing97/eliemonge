class UserController < ApplicationController

  include UserHelper

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
      
      # use the access token as an agent to get the home timeline
      JSON.parse user_access_token.get(api_call).body
    end 

end
