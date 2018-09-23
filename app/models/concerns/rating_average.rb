module RatingAverage
  extend ActiveSupport::Concern

  def average_rating
    array = []
    lukumaara = ratings.count
    ratings.each do |rating|
      array.push(rating.score)
    end
    total = array.reduce(:+) / lukumaara
    total
  end
end
