# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'news-api'
require 'byebug'



newsapi = News.new("e6c6bd1756024aafb44958a68870e0a5")             

top_headlines = newsapi.get_top_headlines(country: 'us',
                                          pageSize: 100)

# totalResults / pageSize rounded up = total pages

authors = top_headlines.map do |article| 
  if !!article.author && article.author != ""
    article.author
  end
end.compact


byebug
0