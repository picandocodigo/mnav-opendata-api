# Museum API

MNAV - Museo Nacional de Artes Visuales provides [open data](http://www.mnav.gub.uy/cms.php?id=datosabiertos) on its artists and works. They are related (a work belongs_to an artist) with an internal ID and the data is provided in CSV format.

I want to build an API around this data. A web application you can query about Artists and Works from the museum.

The application has two parts:

* Processing and saving the data to a database with the correct associations of works and artists.
* Providing an api to get this information in JSON / XML formats (adding parameters, etc.)

Once the application is finished, create a front-end as an example for the API.
What I've thought so far:

* List artists per year, go into the artist's page and see his/her works.
* Display a timeline, use some nice and flashy JS to display a dinamyc timeline of the authors and works.

I want to use Rails for this. Though you may consider Rails to be overkill and may feel tempted to suggest Sinatra or other similar, I need to get practice on Rails.

One of the goals is to demand more open data from this and other national museums, maybe even manage to get most of the museum's works processed. There are 137 works listed in the open data from about 4,000. There are 876 who have works in the MNAV museum, 918 in the open data, and about 1,500 relieved including from other museums. There is no centralized info on this, so every library, museum or art institute in Uruguay does this from scratch.

There are pictures available for the works, but they have the museum's copyright. 
They can be accessed via URL:
`http://www.mnav.gub.uy/obras/mnavXX[WORK_ID].jpg`
The museum holds the copyright (of the pictures, not the work) and each picture has a watermark. Once the app is running I think there'll be no problem in getting permission to use these pictures.

Let me know what you think.