require 'nokogiri'
require 'open-uri'
require 'sqlite3'

#Bygger opp vino.db fra html filer

#types
#Rødvin:0
#Hvitvin:1
#Rosevin:2
#sterkvin:3
#musserendevin:4
#fruktvin:5
#brennevin:6
#øl:7


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
"9" => "aromatisertvin",
"10" => "sider",
"11" => "alkoholfritt",
}

db = SQLite3::Database.new('vino.db')
db.execute "CREATE TABLE vino (id INT, type TINYINT, name VARCHAR(60), volume VARCHAR(10), price INT);"

db.execute "CREATE TABLE usage (noOfTimesUsed INT);"
db.execute "INSERT INTO usage VALUES (0);"

db.execute "CREATE TABLE vinodate (datecreated INT);"
db.execute "INSERT INTO vinodate VALUES (strftime('%s','now'));"

db.execute "create index priceindex on vino (price asc);"
db.execute "create index nameindex on vino (name asc);"
db.execute "create index typeindex on vino (type asc);"

puts "HELLO"
vintyper.each do |type, fileprefix|
	i=1
	while true
		begin
		  filename = fileprefix + i.to_s + ".html"
		  puts filename
		  if(!File.exist?(filename))
			break
		  end
		  page = Nokogiri::HTML(open(filename))
		  products = page.css('div.product-item__info-container')
		  for j in 0 ... products.size
		   name = products[j].css('h2 a').text.strip
		   puts name.size
		   if(name.size != 0)
			   rawid = products[j].css('div.product-item__summary').text
			   productinfo = products[j].css('div.lh-row div.lh-col-50 div.product-item__price-panel div.product-item__price')
			   rawprice = productinfo.css('span.product-item__price').text
			   rawvolume = productinfo.css('span.product-item__amount').text.strip

				puts name
				puts rawid
				puts rawvolume
				puts rawprice
	
				id = rawid.match(/(([0-9]+))/)[0]
				volume = "-"
				if(rawvolume.size != 0)
				  volume = rawvolume[1..-2]
				end
				#Kr. 1 525,00
				s0 = rawprice.strip
				s1 = s0.gsub(/\s+/, "")
				puts "s1:"+s1
				s2 = s1[3,s1.length]
				puts "s2:"+s2
				s3 = s2.delete(",")
				puts "s3:"+s3
				s4 = s3.delete(".")
				puts "s4:"+s4
				s5 = s4.gsub("-","00")
				puts "s5:"+s5
				s6 = s5.gsub(/[^0-9]/, "")
				puts "s6:"+s6
				price =s6.to_i
				print price
				print "\n"
	
				puts name
				puts id
				puts price
				puts volume
			wine = {}
			wine[:id] = id
			wine[:type] = type;
			wine[:name] = name
			wine[:volume] = volume
			wine[:price] = price
			db.execute("INSERT INTO vino VALUES (:id,:type, :name,:volume,:price);",wine)
		   end #end if name
		  end #end for

		  i=i+1
		rescue 
	#	  break
			raise
			#raise e
		end #end rescue
	end #end while true
end #end for each vintype
  

