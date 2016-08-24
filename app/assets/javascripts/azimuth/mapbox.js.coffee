Azimuth = window.Azimuth or {}

Azimuth.Mapbox = {
  urlFor: (styleId, token) -> "https://api.mapbox.com/styles/v1/artsyroop/#{styleId}/tiles/256/{z}/{x}/{y}?access_token=#{token}"
}

window.Azimuth = Azimuth
