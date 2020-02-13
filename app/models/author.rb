class Author < ApplicationRecord
  has_many :article_authors
  has_many :articles, through: :article_authors
  has_many :publications, through: :articles
  has_many :ratings
  has_many :users, through: :ratings


  def article_count
    self.articles.length
  end

  def total_ratings
    self.ratings.length
  end

  def average_likeabiity
    if total_ratings == 0 
      return 0
    else
      total_likes = 0
      self.ratings.each {|rating| total_likes += rating.likeability }
      avg_likes = total_likes / self.total_ratings
      avg_likes.round(2)
    end
  end


  
  def average_integrity
    if total_ratings == 0 
      return 0
    else
      total_integrity = 0
      self.ratings.each {|rating| total_integrity += rating.integrity }
      avg_integrity = total_integrity / self.total_ratings
      avg_integrity.round(2)
    end
  end

end
