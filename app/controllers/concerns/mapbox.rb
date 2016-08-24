module Mapbox
  extend ActiveSupport::Concern

  included do
    before_action :set_mapbox_token
  end

  def set_mapbox_token
    @mapbox_token = Rails.application.config_for(:mapbox)['access_token']
  end
end
