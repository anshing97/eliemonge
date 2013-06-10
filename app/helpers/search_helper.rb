module SearchHelper

  require 'discogs'

  def discogs_api
		@discogs_api ||= Discogs::Wrapper.new("My awesome web app")
  end 

  def search_discogs (search_term)
  	discogs_api.search (search_term)
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
