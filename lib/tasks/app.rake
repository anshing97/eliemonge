namespace :elie do 

	desc 'Test discog api'
	task :search => :environment do 

		agent = Mechanize.new { |agent|
		  agent.user_agent_alias = 'Mac Safari'
		}

		agent.get('http://www.google.co.in/imghp?sbi=1') do |upload_page|

			upload_form = upload_page.form('f')

			# pp upload_form


			# upload_form.q = "https://s3.amazonaws.com/elie/javelin_no_mas.jpg"

			# upload_form.q = "https://s3.amazonaws.com/elie/music_test_image.jpg"

			# upload_form.q = "http://flash.atlrec.com/myspace/jamesblunt/bedlam.jpg"

			upload_form.q = "http://clubs.calvin.edu/chimes/issue_images/106/10/Multi%20Full%20Coldplay%20Mylo%20Xyloto.jpg"


			# upload_form.q = "javelin no mas"

			result_page = agent.submit(upload_form)

			final_page = agent.click(result_page.link_with(:text => "search by image"))

			doc = Nokogiri::HTML(final_page.body)
			names = doc.xpath('//div[@id="topstuff"]/div/a').map do | stuff | 
				stuff.content 
			end 

			puts names.reject! { |e| e.empty? }.first




			# num = final_page.links.find_index { |l| l.text == "Large" }

			# puts final_page.links[num+1].text



			# new_page =  agent.click(upload_page.link_with(:text => 'Web History'))

			# pp new_page

			# form_page = agent.click(upload_page.link_with(text: 'Advanced Image Search'))
			
			# pp form_page

			# pp new_page


			# page = agent.page.links.find { |l| l.text == 'News' }.click
			# pp upload_page

		end

		# wrapper = Discogs::Wrapper.new("My awesome web app")
		# # search = wrapper.search("wicked original cast recording")
		# search = wrapper.search("javelin No Mas")


		# # puts search.to_json

		# puts "------------- exact search -------------"
		# search.exact.each do |el|
		# 	puts "type: #{el.type} title: #{el.title} thumb: #{el.thumb}"
		# end 

		# puts "------------- exact search -------------"
		# search.results.each do |el|
		# 	puts "type: #{el.type} title: #{el.title} summary: #{el.summary} thumb: #{el.thumb}"
		# end 

	end 


end 