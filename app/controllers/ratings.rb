module Bookworm
  module Controllers
    class Ratings < Bookworm::App
      App.get '/book/:id/rating/?' do
        erb :rating
      end

      App.post '/book/:id/rating/?' do
        @book.ratings.post(score: params[:score])
        redirect back
      end

      App.before '/book/:id*' do
        @book = @api.book.where(id: params[:id])
      end
    end
  end
end
