module Sinatra
  module Widgets
    def star_rating(value)
      output = ''
      (1..5).each do |n|
        output += if n > value
                    '<i class="fa fa-lg fa-star-o"></i>'
                  else
                    '<i class="fa fa-lg fa-star"></i>'
                  end
      end
      output
    end
  end
end
