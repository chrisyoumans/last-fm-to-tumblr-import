require 'json'

class LastFmArtist
	attr_reader :name, :playcount, :url, :image_url, :ranking

  def initialize(name, playcount, url, image_url, ranking)
    @name = name
    @playcount = playcount
    @url = url
    @image_url = image_url
    @ranking = ranking
  end

  def to_json(*a)
    {
        'artist'  => [@name, @playcount, @url, @image_url, @ranking]
    }.to_json(*a)
  end

  def self.json_create(o)
    new(*o['data'])
  end

end