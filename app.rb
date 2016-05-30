require 'rubygems'
require 'bundler'

Bundler.require

require 'sinatra/base'
require 'sinatra/flash'
require 'tilt/erb'

require_relative 'app/helpers/auth'
require_relative 'app/helpers/domain'
require_relative 'app/helpers/links'
require_relative 'app/helpers/widgets'

module Bookworm
  class App < Sinatra::Base
    use Rack::Session::Pool
    register Sinatra::Flash

    helpers do
      include Sinatra::Auth
      include Sinatra::Domain
      include Sinatra::Links
      include Sinatra::Widgets
    end

    configure do
      set :session_secret, '2df6f62292cc4b4da053e48b7243a71f'
      set :views, settings.root + '/app/views'
    end

    before do
      @api = HyperResource.new(
        root: 'http://localhost:9292/api',
        headers: {
          'Accept' => 'application/hal+json',
          'Authorization' => session[:auth_token] ||= ''
        }
      )
    end

    get '/' do
      redirect '/books'
    end

    # Load app files
    Dir['./app/controllers/*.rb'].each { |file| require file }
  end
end
