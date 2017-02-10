require 'double_bag_ftps'

$file = nil
def OpenFile(filename)
	$file = File.open( filename,"w" )
end
def CloseFile()
	$file.close
end

def myputs(s)
	$file << s
end

OpenFile("vino.txt")

db = SQLite3::Database.new('vino.db')
db.execute "select * from vinodate;" do |row|
  myputs(row[0])
  myputs("\n")
end

CloseFile()
