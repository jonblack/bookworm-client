module Sinatra
  module Domain
    def already_rated?(book_id)
      book = @api.book.where(id: params[:id])
      book.ratings.get.each do |rating|
        return true if rating.user_id == session[:user_id]
      end

      return false
    end
  end
end
