# How to contribute a new experiment

It should be possible to create one-off map hacks by adding a single new view, and a single new action under the `PagesController`.

The following pattern should allow you to get going and iterate reasonably quickly:

* Create a new html view that will be available at `localhost:9000/my-new-map`
* Create a new json endpoint that will be available at `localhost:9000/my-new-map.json`
* Have the former fetch data from the latter and render the map accordingly

Let's say we want to create a new map that displays shows near DUMBO, Brooklyn.

## Setup

0. Set up a **new route**, in `config/routes.rb`

  ~~~ruby
  get 'dumbo_shows', to: 'pages#dumbo_shows'
  ~~~

0. Add it to the **table of contents** that appears on the app's homepage, in `app/views/home/index.html`

  ~~~haml
  %li
    .toc__name= link_to "Dumbo Shows", dumbo_shows_path
    .toc__desc An <code>Azimuth.DumboShowMap</code>, which displays shows near Dumbo
  ~~~

## Client side

0. Create the corresponding page as a **new view** for the PagesController.

  In a nutshell:

  * add a friendly title
  * add a DOM node for the map to live inside of
  * create some custom js behavior for this experiment

  In `app/views/pages/dumbo_shows.html.haml`:

  ~~~haml
  -# A helper for titling the map in the viewport and title bar
  - map_title "Dumbo Shows" do
    %p This map gives an overview of shows in/near Dumbo

  -# A fullscreen DOM node, into which we will insert the map
  #map{ style: 'position: absolute; left: 0, top: 0; width: 100%; height: 100%; z-index: -1' }
  ~~~

  In the same file you can add inline SCSS, courtesy of the HAML interpreter...

  ~~~scss
  :scss
    #map {
      border: solid 5px red;
    }
  ~~~

  In the same file you can add inline Coffeescript, courtesy of the HAML interpreter...

  ~~~coffeescript
  -# All client-side code should be namespaced under Azimuth.*
  -# Below here is where the bulk of your code will go...

  :coffeescript
    # Initial center of map
    Azimuth.DUMBO = [40.703516, -73.989191]

    # A new map class for this hack
    class Azimuth.DumboShowMap
      constructor: (options = {}) ->
        { selector, mapOptions } = options
        # save a reference to the dom node
        @$el = $(selector)
        @initialize mapOptions
        @fetchData()

      # initial render
      initialize: (options) ->
        # instantiate the Leaflet map
        @map = L.map @$el.get(0), options
        @markers = L.featureGroup().addTo(@map)
        @map.addLayer L.tileLayer.provider 'Esri.WorldGrayCanvas'

      fetchData: ->
        # more to come...

      updateMap: (data) ->
        # more to come...

    # Page initialization
    $ ->
      map = new Azimuth.DumboShowMap
        selector: '#map'
        mapOptions:
          center: Azimuth.DUMBO
          zoom: 16
  ~~~

  At this point you have a boilerplate page with a new map, centered on DUMBO, that doesn't yet do anything.

## Server side

0. Set up a **new server-side action** to render the map, as well as fetch the upstream data you are interested in.

  In a nutshell:

  * Respond to an HTML request (http://localhost:9000/dumbo_shows) by rendering the page you just created

  * Respond to a JSON request (http://localhost:9000/dumbo_shows.json) by fetching/transforming the necessary upstream data and returning it

  * In the final step, we will stitch these two halves together

  In `app/controllers/pages_controller.rb`:

  ~~~ruby
    def dumbo
      respond_to do |format|
        # GET /dumbo_shows => render the map page
        format.html

        # GET /dumbo_shows.json => fetch the needed data from Gravity
        format.json do
          # Prolly you want this:
          response = ShowsService.call(latlng: [40.703516, -73.989191])
          render json: response

          # But you could also fetch shows by other means such as:
          # response = Kinetic::PartnerShow.list
          # render json: response
          #
          # Or something very customized with a Typhoeus request:
          # hydra = Typhoeus::Hydra.new
          # hydra.queue(request1)
          # hydra.queue(request2)
          # hydra.run # blocks until all requests fulfilled
          # response = [request1, request2].map { |request| JSON.parse(request.response.body) }
          # response.flatten!
          # render json: response
        end
      end
    end
  ~~~

## Stitch it together

0. **Update your client-side code** to handle this data. Let's flesh out the bottom part (the client-side js code) of the view we created.

  Back to `app/views/pages/dumbo_shows.html.haml`:

  ~~~coffeescript
  :coffeescript
    # Initial center of map
    Azimuth.DUMBO = [40.703516, -73.989191]

    # A new map class for this hack
    class Azimuth.DumboShowMap
      constructor: (options = {}) ->
        { selector, mapOptions } = options
        # save a reference to the dom node
        @$el = $(selector)
        @initialize mapOptions
        @fetchData()

      # initial render
      initialize: (options) ->
        # instantiate the Leaflet map
        @map = L.map @$el.get(0), options
        @markers = L.featureGroup().addTo(@map)
        @map.addLayer L.tileLayer.provider 'Esri.WorldGrayCanvas'

      # vvvvv NEW STUFF vvvvv

      # follow the pattern of fetching the data from this url + ".json"
      fetchData: ->
        $.getJSON location + '.json'
          .done (data) =>
            @updateMap data
          .fail ->
            alert 'Could not fetch the data!'

      # add a Leaflet marker for each show, and recenter
      updateMap: (data) ->
        _.each data, (show) =>
          if show.location?
            { id, name, location : { coordinates } } = show
            showLink = '<a href="https://www.artsy.net/show/' + id + '">' + name + '</a>'
            marker = L.marker coordinates
            marker.bindTooltip showLink
            @markers.addLayer marker
        # derive a bounding box for this batch of coordinates and recenter accordingly
        @map.fitBounds @markers.getBounds()

      # ^^^^^ NEW STUFF ^^^^^

    # Page initialization
    $ ->
      map = new Azimuth.DumboShowMap
        selector: '#map'
        mapOptions:
          center: Azimuth.DUMBO
          zoom: 16

  ~~~

## Summary

* We added one new file to the project: `app/views/pages/dumbo_shows.html.haml`

* We added one new controller action to render the view and fetch the upstream data

* We updated routes and the homepage accordingly

* If all went well we now have a Dumbo show map at [http://localhost:9000/dumbo_shows](http://localhost:9000/dumbo_shows)
