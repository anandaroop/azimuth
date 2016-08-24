class PagesController < ApplicationController
  include ShowSampling
  include Mapbox

  HQ_LATLNG = [40.7189608, -74.0027938].freeze
  NYC_LATLNG = [40.71, -74.01].freeze

  layout 'fullscreen_map'

  def user_coordinates
    user = User.find(current_user.id)
    @coordinates = user.location['coordinates']
  end

  def nyc_100
    respond_to do |format|
      format.html
      format.json do
        response = ShowsService.call(latlng: HQ_LATLNG, pages: 10)
        render json: response
      end
    end
  end

  def moveable
    respond_to do |format|
      format.html
      format.json do
        @latlng = params.fetch(:latlng, HQ_LATLNG.join(',')).split(',').map(&:to_f)
        response = ShowsService.call(latlng: @latlng, pages: 5)
        render json: response
      end
    end
  end

  def dotmap
    respond_to do |format|
      format.html
      format.json do
        response = ShowsService.call(latlng: HQ_LATLNG, pages: 5)
        render json: response
      end
    end
  end

  def mapbox
    sample_shows
  end

  def carousel
    sample_shows
  end

  def hackathon_vanilla
    sample_shows pages: 3
  end

  def hackathon_styled
    sample_shows pages: 3
  end

  def hackathon_city
    sample_shows pages: 3
  end

  def hackathon_cities
    @latlng = params.fetch(:latlng, NYC_LATLNG.join(','))
    respond_to do |format|
      format.html
      format.json do
        response = ShowsService.call(latlng: @latlng.split(',').map(&:to_f), pages: 5)
        render json: response
      end
    end
  end
end
