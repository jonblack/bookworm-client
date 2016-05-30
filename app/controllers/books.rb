module Bookworm
  module Controllers
    class Books < Bookworm::App
      App.get '/books/?' do
        erb :books
      end

      App.get '/book/:id/?' do
        erb :book
      end

      App.before '/book/:id*' do
        @book = @api.book.where(id: params[:id])
      end
    end
  end
end
