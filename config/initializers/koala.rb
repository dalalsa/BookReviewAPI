# In Rails, you could put this in config/initializers/koala.rb
Koala.configure do |config|
#   config.access_token = MY_TOKEN
#   config.app_access_token = MY_APP_ACCESS_TOKEN
  config.app_id = '310813782922639'
  config.app_secret = '5b056da36ce2d0d3e9e73bd004fc28a6'

  # See Koala::Configuration for more options, including details on how to send requests through
  # your own proxy servers.
end