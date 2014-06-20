require 'json'
require 'httparty'
require './lastfm'
require './lastfm_artist'

class WeeklyTopFiveArtistImport < LastFM
  attr_reader :artists

  def initialize
    super
    @artists = Array.new
  end

  def retrieve_weekly_top_five username = "standardtune"
    url = "https://ws.audioscrobbler.com/2.0/?method=user.gettopartists&user=" + username + "&api_key=" + @api_key + "&period=7day&format=json&limit=5"
    puts url
    response = HTTParty.get(url)
    temp_artists = JSON.parse(response.body)

    temp_artists['topartists']['artist'].each do |a|
      @artists.push(LastFmArtist.new(a['name'], a['playcount'], a['url'], a['image'][4]['#text'], a['@attr']['rank']))
    end
  end

  def generate_tags
    tags = 'music, last.fm, weeklytop5,'
    @artists.each do |a|
      tags << a.name + ','
    end
    tags.chop
    return tags
  end

  def wrap_artists_in_html_for_tumblr
    self.sort_artists_by_ranking

    html = "<p>"
    html << "<img src='" + @artists.at(0).image_url + "' />"
    html << "<ol>"

    @artists.each do |a|
      html << "<li><a href='" + a.url + "'>" + a.name + " (" + a.playcount + ")" + "</a></li>"
    end

    html << "</ol>"
    html << "</p>"
  end

  def sort_artists_by_ranking
    @artists.sort! { |a,b| a.ranking <=> b.ranking }
  end

end