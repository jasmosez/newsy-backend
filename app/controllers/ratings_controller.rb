class RatingsController < ApplicationController

  # this controller's show action expects an AUTHOR ID rather than a rating id
  def show
    author_ratings = Rating.all.select do |r|
      r.author_id == params[:id].to_i
    end
    render json: author_ratings
  end
  
  def create
    new_rating = Rating.create(rating_params)
    render json: new_rating
  end

  def update
    rating = Rating.find(params[:id].to_i)
    rating.update(rating_params)
    render json: rating
  end

  def destroy
    rating = Rating.find(params[:id].to_i)
    rating.destroy
  end

  private

  def rating_params
    params.require(:rating).permit(:likeability, :integrity, :author_id, :user_id)
  end
      

end
