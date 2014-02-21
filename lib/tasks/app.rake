namespace :elie do 

	desc 'Test discog api'
	task :search => :environment do 

		agent = Mechanize.new { |agent|
		  agent.user_agent_alias = 'Mac Safari'
		}

		agent.get('http://www.google.co.in/imghp?sbi=1') do |upload_page|

			upload_form = upload_page.form('f')

			upload_form.q = "http://upload.wikimedia.org/wikipedia/en/a/a7/Random_Access_Memories.jpg"

			result_page = agent.submit(upload_form)

			final_page = agent.click(result_page.link_with(:text => "search by image"))

			doc = Nokogiri::HTML(final_page.body)
			names = doc.xpath('//div[@id="topstuff"]/div/a').map do | stuff | 
				stuff.content 
			end 

			puts names.reject! { |e| e.empty? }.first

		end

	end 

	desc 'Testing discogs'
	task :discogs => :environment do 

		HOST = "http://api.discogs.com"
		PATH = "/database/search"
		query = "q=random access memories&format=vinyl"

		request = Net::HTTP::Get.new(HOST + PATH + "?" + URI.escape(query))
		request.add_field("Accept", "application/json")
		request.add_field("User-Agent", "Recccords")

		response = Net::HTTP.new("api.discogs.com").start do |http|
			http.request(request)
		end 

		r = JSON.parse(response.body)		
		r['results'].each do | el |
			puts '------------' 
			puts el['thumb']
			puts 'www.discogs.com' + el['uri']
			puts el['title']
		end 

	end

end 