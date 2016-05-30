module Bookworm
  module Controllers
    class Authors < Bookworm::App
      App.get '/authors/?' do
        erb :authors
      end

      App.get '/author/:id/?' do
        erb :author
      end

      App.before '/author/:id*' do
        @author = @api.author.where(id: params[:id])
      end
    end
  end
end
