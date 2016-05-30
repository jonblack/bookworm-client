require 'sinatra/base'

module Sinatra
  module Links
    def active_page?(path = '')
      request.path_info == '/' + path
    end
  end

  helpers Links
end
