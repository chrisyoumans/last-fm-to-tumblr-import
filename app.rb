require 'sinatra'
require 'JSON'
require './weekly_top_five_artist_import'
require './tumblr'

# list with default username
get '/lastfm/weeklytopfive' do
  import = WeeklyTopFiveArtistImport.new
  import.retrieve_weekly_top_five
  import.artists.to_json
  body = import.wrap_artists_in_html_for_tumblr
  tags = import.generate_tags
  tum = TumblrMine.new
  tum.post_to_tumblr('My Top 5 Artists (Week Ending ' + DateTime.now.strftime('%m/%d/%Y') + ')', body, tags)
end

# list with username param
get '/lastfm/weeklytopfive/:username' do
  import = WeeklyTopFiveArtistImport.new
  import.retrieve_weekly_top_five("#{params[:username]}")
  import.artists.to_json
  body = import.wrap_artists_in_html_for_tumblr
  tags = import.generate_tags
  tum = TumblrMine.new
  tum.post_to_tumblr('My Top 5 Artists (Week Ending ' + DateTime.now.strftime('%m/%d/%Y') + ')', body, tags)
end