require './env' if File.exists?('env.rb')

class LastFM
	attr_reader :api_key, :secret

  def initialize
    @api_key = ENV["LASTFM_API_KEY"]
 	@secret = ENV["LASTFM_API_SECRET"]
  end

end