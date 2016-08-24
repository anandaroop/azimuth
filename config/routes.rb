Rails.application.routes.draw do

  root to: 'home#index'

  get 'hq', to: 'pages#hq'
  get 'user_coordinates', to: 'pages#user_coordinates'
  get 'evented', to: 'pages#evented'
  get 'geolocation', to: 'pages#geolocation'
  get 'nyc_100', to: 'pages#nyc_100'
  get 'moveable', to: 'pages#moveable'
  get 'dotmap', to: 'pages#dotmap'
  get 'mapbox', to: 'pages#mapbox'
  get 'hackathon/(:slug)', to: 'pages#hackathon_cities', as: 'hackathon'

end
