module SearchHelper

	require 'net/http'
	require 'uri'

	DISCOGS_API = "http://api.discogs.com/database/search"

	def search_discogs (term) 
		uri = URI(DISCOGS_API)

		request = Net::HTTP::Get.new(uri.to_s + "?" + query_string(term))
		request.add_field("Accept", "application/json")
		request.add_field("User-Agent", "Recccords")

		Net::HTTP.new(uri.host).start do |http|
			http.request(request)
		end 
	end 

	def query_string ( term ) 
		query = {:q => term, :format => 'vinyl', :type => 'release'}
		URI.escape query.map { |k,v| "#{k}=#{v}" }.join('&')
	end 


  def mechanize_agent
  	@agent ||= Mechanize.new { |agent|
			agent.user_agent_alias = 'Mac Safari'
		}
  end

  GOOLGE_SEARCH_URL = 'http://www.google.co.in/imghp?sbi=1'
  INTERMEDIATE_PAGE_BUTTON = 'search by image'

  def google_album_art (img_url)

  	name = nil

  	begin 
		mechanize_agent.get(GOOLGE_SEARCH_URL) do |upload_page|

			upload_form = upload_page.form('f')

			upload_form.q = img_url

			intermediate_page = mechanize_agent.submit (upload_form)

			final_page = mechanize_agent.click(intermediate_page.link_with(:text => INTERMEDIATE_PAGE_BUTTON))

			name = find_album_name (final_page.body)

		end
	rescue 
		name = nil
	end 

	name 

  end 

  def find_album_name (html) 
		doc = Nokogiri::HTML(html)
		names = doc.xpath('//div[@id="topstuff"]/div/a').map do | stuff | 
			stuff.content 
		end
		names.reject! { |e| e.empty? }
		names.first		
	end 

end
