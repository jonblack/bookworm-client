module Bookworm
  module Controllers
    class Users < Bookworm::App
      App.get '/users/signup/?' do
        erb :signup
      end

      App.post '/users/signup/?' do
        begin
          response = @api.signup.post(
            username: params['username'],
            password: params['password']
          )
        rescue HyperResource::ClientError => e
          flash[:signup_error] = e.body['message']
          redirect back
        end

        session[:user_id] = response.body['id']
        session[:username] = response.body['username']
        session[:auth_token] = response.body['auth_token']

        redirect '/'
      end

      App.get '/users/login/?' do
        erb :login
      end

      App.post '/users/login/?' do
        begin
          response = @api.login.post(
            username: params['username'],
            password: params['password']
          )
        rescue HyperResource::ClientError => e
          flash[:login_error] = e.body['message']
          redirect back
        end

        session[:user_id] = response.body['id']
        session[:username] = response.body['username']
        session[:auth_token] = response.body['auth_token']

        redirect '/'
      end

      App.post '/users/logout/?' do
        # The user may have logged out in a different browser/tab/device
        @api.logout.post(username: session[:username]) if authenticated?

        # Use POST for logging out because of browser pre-fetching
        session.clear
        redirect back
      end

      App.get '/user/:id/ratings/?' do
        erb :user_ratings
      end

      App.before '/user/:id*' do
        @user = @api.user.where(id: params[:id])
      end
    end
  end
end
