class SearchController < ApplicationController

  include SearchHelper
  include UserHelper

  def index

    @results = nil
    @name = nil
    @image = Image.new

    unless ( params[:img_url].nil? ) then 

      album_name = google_album_art(params[:img_url]) 

      if album_name.nil? 
        flash.now[:error] = "Did you enter the url for an image?" 
      elsif album_name.empty?  
        flash.now[:error] = "Can't find album name for this"
      else 

        r = search_discogs(album_name)
        @response = JSON.parse(r.body)

        @response['results'].each do | el | 

          uri = URI.parse(el['thumb'])
          resp = user_access_token.get(el['thumb'])

          file_name = File.basename(uri.path)
          open( file_name,"wb") { |file|
            file.write(resp.body)
          }

          @image = Image.new(:image => File.open(file_name))

          if @image.save
            puts @image.image.url
          end 
        end 

        # puts JSON.pretty_generate(@response)
 
        @name = album_name
      end 

    end 

  end



end
