require 'nokogiri'
require 'open-uri'
require 'openssl'
require 'nokogiri'
require 'net/https'
require 'mechanize'
require 'json'

agent = Mechanize.new
baseurl = "https://www.vinmonopolet.no"

#https://www.vinmonopolet.no/vmpSite/Nettbutikk-kategorier/R%C3%B8dvin/c/r%C3%B8dvin?q=::mainCategory:r%C3%B8dvin
#https://www.vinmonopolet.no/vmpSite/Nettbutikk-kategorier/R%C3%B8dvin/c/r%C3%B8dvin?q=%3Arelevance%3AmainCategory%3Ar%C3%B8dvin%3AvisibleInSearch%3Atrue&page=0&searchType=
urls = {
"rodvin"        => "/vmpws/v2/vmp/search?fields=FULL&pageSize=24&searchType=product&currentPage=0&q=%3Arelevance%3AmainCategory%3Ar%C3%B8dvin",
"hvitvin"       => "/vmpSite/Nettbutikk-kategorier/Hvitvin/c/hvitvin?q=::mainCategory:hvitvin",
"rosevin"       => "/vmpSite/Nettbutikk-kategorier/Ros%C3%A9vin/c/ros%C3%A9vin?q=::mainCategory:ros%C3%A9vin",
"sterkvin"      => "/vmpSite/Nettbutikk-kategorier/Sterkvin/c/sterkvin?q=::mainCategory:sterkvin",
"musserendevin" => "/vmpSite/Nettbutikk-kategorier/Musserende-vin/c/musserende_vin?q=::mainCategory:musserende_vin",
"fruktvin"      => "/vmpSite/Nettbutikk-kategorier/Fruktvin/c/fruktvin?q=::mainCategory:fruktvin",
"brennevin"     => "/vmpSite/Nettbutikk-kategorier/Brennevin/c/brennevin?q=::mainCategory:brennevin",
"ol"            => "/vmpSite/Nettbutikk-kategorier/%C3%98l/c/%C3%B8l?q=::mainCategory:%C3%B8l",
"perlendevin"	=> "/vmpSite/Nettbutikk-kategorier/Perlende-vin/c/perlende_vin?q=::mainCategory:perlende_vin",
"sider"			=> "/vmpSite/Nettbutikk-kategorier/Sider/c/sider?q=::mainCategory:sider",
"alkoholfritt"	=> "/vmpSite/Nettbutikk-kategorier/Alkoholfritt/c/alkoholfritt?q=::mainCategory:alkoholfritt",
"aromatisertvin" => "/vmpSite/Nettbutikk-kategorier/Aromatisert-vin/c/aromatisert_vin?q=::mainCategory:aromatisert_vin"
}

#https://stackoverflow.com/questions/2759073/using-openuri-how-can-i-get-the-contents-of-a-redirecting-page
urls.each do |key, nexturl|
  puts key
  puts nexturl
	i=1
	while nexturl
	
	  openurl = baseurl + nexturl
	  #page = Nokogiri::HTML(open(openurl))

      page = agent.get openurl

	  filename = key + i.to_s + ".json"
	  
	  i=i+1
	  puts filename
	  File.open(filename, 'w') { |file| file.write(page.content) }
	  parsed_json = JSON.parse(page.content)
	  page_info = parsed_json['contentSearchResult']['pagination']
	  puts page_info
	  exit
	  pagination = parsed_json['pagination']
	  current_page = pagination['currentPage']
	  total_pages = pagination['totalPages']

	  puts "Current Page: #{current_page}"
      puts "Total Pages: #{total_pages}"
	  exit
	  links = page.css('aria-label').select{|link| link['rel'] == "next"} 
	  nexturl = false
	  links.each{|link| 
	  	 nexturl = link['href'] 
	  	 puts "NEXTURL"
	     puts nexturl
	  }
	  puts "Sleep 2 seconds"
	  sleep(2)
  end
end
