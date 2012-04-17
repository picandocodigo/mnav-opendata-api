# Museum API

MNAV - Museo Nacional de Artes Visuales provides [open data](http://www.mnav.gub.uy/cms.php?id=datosabiertos) on its artists and works. They are related (a work belongs_to an artist) with an internal id and the data is provided in CSV format.

This API includes the following functionality:

* Retrieve MNAV's open data files
* Process artists and artwork data and save them into the database
* Provide this data in XML and JSON

## Retrieving MNAV's data

MNAV provides it's data in CSV format. You can run the data_retrieval.rb class in lib/data via command line:

`./data_retrieval.rb`

The url and name for the files are set in lib/data/data.yaml. The script uses wget to download them and iconv to convert them from ISO-8859-1 to UTF-8.

## Process data

The ProcessData module saves the information in the database. There's two main methods:

**process_artists(file)**

The file parameter can be a String with a path to a csv file, or an IO Object (StringIO). Eg.:
`ProcessData.process_artists('~/data/artists.csv')`

**process_artworks(file)**

Same params as process_artists.

There's a wrapper for these two methods:

**process(type, file)**

The type parameter must be a String, either "artist" or "artwork". The file parameter is the same as before. Example:
`ProcessData.process('artist', '~/data/artwork.csv')`


## Using the API
Once you've processed the data and run your app, you can query the API for artists and artworks. Default format is JSON, but you can get XML by specifying it in the request

### Artists

`GET /artist/:id`
Gets an artist's information.

`GET /artist/:id/artworks`
Get an artist's artwork.

`GET /artists`
This route receives one of two parameters to search for artists:

*name* - String
`GET /artists?name=Juan`

*birth* - Integer, year range of an artist's birth year
`GET /artists?birth[]=1900&birth[]=1950`

### Artworks

`GET /artwork/:id`
Gets an artwork's information

`GET /artworks`
Also receives two parameters:

*technique* - String, search artworks by technique
`GET /artworks?technique=oleo`

*year* - Can be Integer or an Array of integers.
`GET /artworks?year=1950`
or:
`GET /artworks?year[]=1900&year[]=1950`

## Motivation

One of the goals of this project is to demand more open data from this and other national museums, maybe even manage to get most of the museum's works processed. There are 137 works listed in the open data from about 4,000. There are 876 who have works in the MNAV museum, 918 in the open data, and about 1,500 relieved including from other museums. There is no centralized info on this, so every library, museum or art institute in Uruguay does this from scratch.

There are pictures available for the works, but they have the museum's copyright. 
They can be accessed via URL:
`http://www.mnav.gub.uy/obras/mnavXX[WORK_ID].jpg`
The museum holds the copyright (of the pictures, not the work) and each picture has a watermark. When used for publications or catalogs, the museum requests a donation (a computer or similar for the museum).

## Copyright

Author: Fernando Briano
Development sponsored by [Cubox](http://cuboxlabs.com)