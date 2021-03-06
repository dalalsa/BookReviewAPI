class Review < ApplicationRecord
    before_save :calculate_avrage_rating
    belongs_to :user
    belongs_to :book

    def calculate_avrage_rating
        self.average_rating = ((self.content_rating.to_f + self.recommend_rating.to_f)/2).round(1)
    end
end
