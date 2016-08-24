Azimuth = window.Azimuth or {}

Azimuth.Icons = {
  
  # a clone of Leaflet's default icon, but with a custom gray marker
  GrayIcon: L.icon
    iconUrl: '/assets/icons/marker-gray-icon.png' # custom
    iconSize: [25, 41]
    iconAnchor: [13, 40]
    popupAnchor: [0, -33]
    shadowUrl: '/assets/leaflet/images/marker-shadow.png' # default
    shadowSize: [41, 41]
    shadowAnchor: [14, 41]
}

window.Azimuth = Azimuth
