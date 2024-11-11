# polpriser
Rubyscripts for å hente prisene på vinmonopolets varer.

# Bruksanvisning
Jeg lagde denne koden for å lage en sqlite3 database som jeg bruker i appen
[polpriser](https://itunes.apple.com/us/app/polpriser-gratis/id877297213?mt=8).

Jeg gjør følgende:

- `ruby gethtmlfiles.rb`

   Dette henter ned alle websidene med varene til vinmonopolet. En og en side hentes med
   30 sekunders pause for ikke å bli oppfattet som et angrep på vinmonopolets nettsted.

- `ruby createvinodb.rb`
 
   Dette opprettet databasen vino.db, parser alle html filene og legger varene inn i databasen.

- `ruby createversionfile.rb`
 
   Dette oppretter en versjonsfil vino.txt. Appen leser innholdet i denne filen og sammenligner
   med versjonen den har av databasen. Dersom vino.txt viser at det er en nyere versjon, lastes 
   databasen ned.

# Docker
Hvis du ikke har ruby installert på maskinen eller du får feilmeldinger om manglende biblioteker,
 ssl-feil etc. kan du installere [docker](hub.docker.com) og kjøre følgende kommandoer i et
 terminalvindu:
 
- `docker build -t polpriser .`

   Dette bygger docker imaget 'polpriser'

-  `./startdocker.sh`
 
   Dette starter en Ubuntu linux maskin i terminalvinduet.
 
- `cd` 
 
   Dette endrer aktiv arbeidsmappe til /root
 
- `./doit.sh`
 
   Dette kjører de tre ruby scriptene beskrevet over i rekkefølge.

# Kilder
Jeg mener jeg tok utgangspunkt i [denne filen](https://gist.github.com/evenv/3035416) da jeg lagde mine script.

