class SearchController < ApplicationController

  include SearchHelper

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
				
				@name = album_name
			end 

		end 

  end



end
