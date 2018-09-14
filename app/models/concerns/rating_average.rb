module RatingAverage
 extend ActiveSupport::Concern

    def average_rating
    array = []
    lukumaara = self.ratings.count
      self.ratings.each do |rating|
        array.push(rating.score)
      end
      total = array.reduce(:+) / lukumaara
      return total
    end  

end