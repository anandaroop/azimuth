module ShowSampling
  extend ActiveSupport::Concern

  # helper method that makes it very easy to
  # - respond to the html request with the corresp template
  # - respond to the json request with a list of shows near a
  #   point supplied in the URL params. by default it is 2 pages
  #   of results centered on [40.71,-74.01], i.e. 20 shows near NYC
  def sample_shows(pages: 2)
    respond_to do |format|
      format.html
      format.json do
        nyc = '40.71,-74.01'
        @latlng = params.fetch(:latlng, nyc).split(',').map(&:to_f)
        response = ShowsService.call(latlng: @latlng, pages: pages)
        render json: response
      end
    end
  end
end
