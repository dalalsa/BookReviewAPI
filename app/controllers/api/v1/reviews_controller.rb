class Api::V1::ReviewsController < ApplicationController
  before_action :load_book, only: :index
  before_action :load_review, only: [:show, :update, :destroy]
  before_action :authenticate_with_token!, only: [:create, :update, :destroy]

  def index
    @reviews = @book.reviews
    json_response "Index reviews successuflly", true, {reviews: @reviews}, :ok
  end

  def show
    json_response "show review successuflly ", true, {review: @review}, :ok
  end

  def create
    review = Review.new review_params

    review.user_id = current_user.id
    review.book_id = params[:book_id]
    if review.save
      json_response "Created review successuflly", true, {review: review}, :ok
    else
      json_response "Created review failed", flase, {}, :unprocessable_entity
    end
  end

  def update
    if correct_user @review.user
      if @review.update review_params
        json_response "Updated review sUccessfully", true, {review: @review}, :ok
      else
        json_response "Updated review failed", flase, {}, :unprocessable_entity
      end
    else
      json_response "You dont have permission to do this", false, {}, :unauthorized
    end
  end

  def destroy
    if correct_user @review.user
      if @review.destroy
        json_response "Deleted review sUccessfully", true, {}, :ok
      else
        json_response "Deleted review failed", flase, {}, :unprocessable_entity
      end
    else
      json_response "You dont have permission to do this", false, {}, :unauthorized
    end
  end

  private

  def load_book
    @book = Book.find_by id: params[:book_id]
    unless @book.present?
      json_response "Book not found", false, {}, :not_found
    end
  end

  def load_review
    @review = Review.find_by id: params[:id]
    unless @review.present?
      json_response "Review not found", false, {}, :not_found
    end
  end

  def review_params
    params.require(:review).permit :title, :content_rating, :recommend_rating
  end
end
