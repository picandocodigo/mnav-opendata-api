# Museum API

MNAV - Museo Nacional de Artes Visuales provides [open data](http://www.mnav.gub.uy/cms.php?id=datosabiertos) on its artists and works. They are related (a work belongs_to an artist) with an internal id and the data is provided in CSV format.

This API includes the following functionality:

* Retrieve MNAV's open data files
* Process artists and artwork data and save them into the database
* Provide this data in XML and JSON

## Retrieving and processing MNAV's data

MNAV provides it's data in CSV format. There are a few rake tasks on /lib/task/download_files.rake that you can execute to process the information:

`rake download_files`

Downloads the csv files from the museum's website.

`rake process_artists`

Saves the artists' information in the database.

`rake process_artworks`

Saves the artworks' information in the database.

The url and name for the files are set in lib/data/data.yaml. The csv files are in ISO-8859-1 (latin-1) so they'r transformed to UTF-8 in the process.

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

One of the goals of this project is to demand more open data from this and other national museums, maybe even manage to get most of the museum's works processed. There are 137 works listed in the open data from about 4,000. There are 876 artists who have works in the MNAV museum, 914 in the open data, and about 1,500 relieved including from other museums. There is no centralized info on this, so every library, museum or art institute in Uruguay does this from scratch.

There are pictures available for the works, but they have the museum's copyright. 
They can be accessed via URL:
`http://www.mnav.gub.uy/obras/mnavXX[WORK_ID].jpg`
The museum holds the copyright (of the pictures, not the work) and each picture has a watermark. When used for publications or catalogs, the museum requests a donation (a computer or similar for the museum).

## Copyright

Author: [Fernando Briano](http://picandocodigo.net)

Development sponsored by [Cubox](http://cuboxlabs.com)