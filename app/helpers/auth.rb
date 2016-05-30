module Sinatra
  module Auth
    def authenticated?
      session.key?(:auth_token) && session[:auth_token] != ''
    end
  end
end
