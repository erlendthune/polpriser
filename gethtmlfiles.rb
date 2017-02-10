require 'nokogiri'
require 'open-uri'
require 'openssl'
require 'net/https'


baseurl = "https://www.vinmonopolet.no"

vintyper = {
"0" => "rødvin",
"1" => "hvitvin",
"2" => "rosevin",
"3" => "sterkvin",
"4" => "musserendevin",
"5" => "fruktvin",
"6" => "brennevin",
"7" => "øl",
"8" => "perlendevin",
"9" => "sider",
"10" => "alkoholfritt",
"11" => "aromatisertvin",
}

#https://www.vinmonopolet.no/vmpSite/Nettbutikk-kategorier/R%C3%B8dvin/c/r%C3%B8dvin?q=::mainCategory:r%C3%B8dvin
#https://www.vinmonopolet.no/vmpSite/Nettbutikk-kategorier/R%C3%B8dvin/c/r%C3%B8dvin?q=%3Arelevance%3AmainCategory%3Ar%C3%B8dvin%3AvisibleInSearch%3Atrue&page=0&searchType=
urls = {
"rødvin"        => "/vmpSite/Nettbutikk-kategorier/R%C3%B8dvin/c/r%C3%B8dvin?q=%3Arelevance%3AmainCategory%3Ar%C3%B8dvin%3AvisibleInSearch%3Atrue&page=0&searchType=",
"hvitvin"       => "/vmpSite/Nettbutikk-kategorier/Hvitvin/c/hvitvin?q=::mainCategory:hvitvin",
"rosevin"       => "/vmpSite/Nettbutikk-kategorier/Ros%C3%A9vin/c/ros%C3%A9vin?q=::mainCategory:ros%C3%A9vin",
"sterkvin"      => "/vmpSite/Nettbutikk-kategorier/Sterkvin/c/sterkvin?q=::mainCategory:sterkvin",
"musserendevin" => "/vmpSite/Nettbutikk-kategorier/Musserende-vin/c/musserende_vin?q=::mainCategory:musserende_vin",
"fruktvin"      => "/vmpSite/Nettbutikk-kategorier/Fruktvin/c/fruktvin?q=::mainCategory:fruktvin",
"brennevin"     => "/vmpSite/Nettbutikk-kategorier/Brennevin/c/brennevin?q=::mainCategory:brennevin",
"øl"            => "/vmpSite/Nettbutikk-kategorier/%C3%98l/c/%C3%B8l?q=::mainCategory:%C3%B8l",
"perlendevin"	=> "/vmpSite/Nettbutikk-kategorier/Perlende-vin/c/perlende_vin?q=::mainCategory:perlende_vin",
"sider"			=> "/vmpSite/Nettbutikk-kategorier/Sider/c/sider?q=::mainCategory:sider",
"alkoholfritt"	=> "/vmpSite/Nettbutikk-kategorier/Alkoholfritt/c/alkoholfritt?q=::mainCategory:alkoholfritt",
"aromatisertvin" => "/vmpSite/Nettbutikk-kategorier/Aromatisert-vin/c/aromatisert_vin?q=::mainCategory:aromatisert_vin"
}

urls.each do |key, nexturl|
  puts key
  puts nexturl
	i=1
	while nexturl
	  openurl = baseurl + nexturl
	  page = Nokogiri::HTML(open(openurl))
	  filename = key + i.to_s + ".html"
	  i=i+1
	  puts filename
	  File.open(filename, 'w') { |file| file.write(page) }
	  links = page.css('ul.pagination a').select{|link| link['rel'] == "next"} 
	  nexturl = false
	  links.each{|link| 
	  	 nexturl = link['href'] 
	  	 puts "NEXTURL"
	     puts nexturl
	  }
	  puts "Sleep 30 seconds"
	  sleep(10)
  end
end