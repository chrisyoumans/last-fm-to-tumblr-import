require 'rubygems'
require 'oauth'
require 'tumblr_client'

class TumblrMine
	attr_reader :client

	def initialize
	    # Authenticate via OAuth
		@client = Tumblr::Client.new({
		  :consumer_key => ENV["TUMBLR_CONSUMER_KEY"],
		  :consumer_secret => ENV["TUMBLR_CONSUMER_SECRET"],
		  :oauth_token => ENV["TUMBLR_OAUTH_TOKEN"],
		  :oauth_token_secret => ENV["TUMBLR_OAUTH_TOKEN_SECRET"]
		})
	end

	def post_to_tumblr title, body, tags
  		@client.text('standardtune.tumblr.com', { :title => title, :body => body, :tags => tags })
	end
end