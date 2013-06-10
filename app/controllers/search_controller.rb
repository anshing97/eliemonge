class SearchController < ApplicationController

	include SearchHelper

  def index

  	@results = nil
  	@name = nil

  	unless ( params[:img_url].nil? ) then 

	  	album_name = google_album_art(params[:img_url]) 

	  	if album_name.nil? 
	  		flash.now[:error] = "Did you enter the url for an image?" 
	  	elsif album_name.empty?  
		  	flash.now[:error] = "Can't find album name for this"
		  else 
				@results = search_discogs(album_name) 
				@name = album_name
			end 

		end 

  end



end
