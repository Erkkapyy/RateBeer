class User < ApplicationRecord
    include RatingAverage
    validates :username, uniqueness: true, length: { minimum: 3, maximum: 30 }
    validates :password, format: { with: /\A(?=.*[A-Z])(?=.*[0-9]).{4,}\z/, message: "must be at least 4 characters and include one number and one uppercase letter."}
    has_many :ratings, dependent: :destroy
    has_many :beers, through: :ratings
    has_secure_password
end
