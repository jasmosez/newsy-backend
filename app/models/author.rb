class Author < ApplicationRecord
  has_many :article_authors
  has_many :articles, through: :article_authors
  has_many :publications, through: :articles


  def article_count
    self.articles.length
  end

end
