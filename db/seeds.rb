require 'news-api'
require 'byebug'
require 'rest-client'
require 'json'

##########################################################
# 
# THIS SEED FILE DOESN'T HAVE ANY DESTROYING.
# CONSIDER ADDING AS NEEDED
# 
##########################################################



newsapi = News.new("e6c6bd1756024aafb44958a68870e0a5")             

##########################################################
# Used to seed Publication table on a first pass
##########################################################
sources = newsapi.get_sources(country: 'us', language: 'en')
sources.each do |source|
  Publication.create(
    apiId: source.id,
    name: source.name,
    description: source.description,
    url: source.url,
    category: source.category
  )
end
##########################################################

##########################################################
# Seed Articles table on a second pass. 
# API limits free accounts to 500 requests per day
# API limits free accounts to 100 responses per request
# API limits free accounts to news within 30 days
##########################################################
# Querying articles from POLITICO only
##########################################################

# create array of dates for last 30 days properly formatted for API call
dates = []
ago = 1
30.times do
  d = Date.today - ago
  dates << d.strftime('%Y-%m-%d')
  ago += 1
end

# iterate through last 30 dates
dates.each do |date|

  # call API. 
  # POLITICO tends to retrun about 60 articles per day
  articles = newsapi.get_everything(pageSize: 100,
                                    sources: 'politico',
                                    from: "#{date}&to=#{date}",
                                    language: 'en',)


  # create db record for each article received 
  articles.each do |article|
    Article.create(
      publication_id: 38, #this is POLITICO
      title: article.title,
      author: article.author,
      description: article.description,
      url: article.url,
      urlToImage: article.urlToImage,
      publishedAt: article.publishedAt
    )
  end
end


##########################################################
# code to seed articles from NYTimes API
# API limits to 120 articles per minute, hence the sleep instruction
##########################################################

page = 0
articles_array = []
begin
  response = RestClient.get("https://api.nytimes.com/svc/search/v2/articlesearch.json?api-key=Vke0ScEw3x4w9lNJZNAHF7F49Q0QvM5m&begin_date=20200105&end_date=20200205&fq=news_desk:Politics&fl=headline,byline,web_url,abstract,pub_date&page=#{page}")
  json = JSON.parse(response)
  json["response"]["docs"].each do |article|
    puts "page #{page}"
    puts "saving #{article}"
    puts "length #{articles_array.length}"
    puts "---------------------------"
    articles_array << article
  end


  page += 1
  sleep(6)
end while page <= (json["response"]["meta"]["hits"]/10)


  # create db record for each article received 
  articles_array.each do |article|
    Article.create(
      publication_id: 57, #this is NYTimes
      title: article["headline"]["main"],
      author: article["byline"]["original"],
      description: article["abstract"],
      url: article["web_url"],
      publishedAt: article["pub_date"]
    )
  end

##########################################################
#  method to isolate author names from articles
##########################################################
def author_list
  # get authors of all the articles.
  authors = Article.all.map {|article| article.author}
  # remove blanks
  authors.compact!
  # remove duplicates
  authors.uniq!
  # split multiple names by commas, flatten arrays and remove duplicates
  authors.map! do |author|
    author.split(', ')
  end
  authors.flatten!
  authors.uniq!
  
  # split multiple names by ands, flatten arrays and remove duplicates
  authors.map! do |author|
    author.split(' and ')
  end
  authors.flatten!
  authors.uniq!
    
  # find names in parentheses, isolate them and remove duplicates
  authors.map! do |author|
    if author.match?(/\(.*\)/)
      author.gsub!(/\A.*\(/, '')
      author.gsub!(/\).*\z/, '')
    else 
      author
    end
  end
  authors.uniq!
  
  # find names beginning with By, isolate them and remove duplicates
  authors.map! do |author|
    if author.match?(/\ABy /) 
      author.gsub!(/\ABy /, '')
    else 
      author
    end
  end
  authors.uniq!
  
  # find names in uppercase. Titlecase them and remove duplicates
  authors.map! do |author| 
    if author = author.upcase
      author.titlecase
    else
      author
    end
  end
  authors.uniq!

  # remove names containing specific regular expressions
  authors.filter! do |author|
    !author.match?(/South China Morning Post/) && !author.match?(/ttps/) 
  end
  
  # sort alphabetically
  authors.sort!
end


##########################################################
# code to create author records 
##########################################################
author_list.each do |author|
  Author.create(name: author)
end



##########################################################
# code to create relationships between authors and articles 
##########################################################
Author.all.each do |author|
  Article.all.each do |article|
    if !!article.author
      if article.author.downcase.match?(author.name.downcase)
        ArticleAuthor.create(author_id: author.id, article_id: article.id)
      end
    end
  end
end






# byebug
# 0

# article_hash = {publication_id: 57, title: article["headline"]["main"],author: article["byline"]["original"],description: article["abstract"],url: article["web_url"],publishedAt: article["pub_date"]}


# ################################################
# METHODS TO POPULATE DUMMY IMAGES AND RATNGS
# These are not called in this seeds.rb file, but can be copied and pasted to a console
# ################################################

# method to populate images for articles that don't have any
def populate_missing_article_images
  no_imgs = Article.all.select {|a| !a.urlToImage}

  url = "https://picsum.photos/450"

  no_imgs.each do |img|
      response = RestClient.get(url)    
      id = response.headers[:picsum_id]
      
      # parse response string into parsed_string
      parsed_url = "https://i.picsum.photos/id/#{id}/300/200.jpg"

      img.update(urlToImage: parsed_url)
  end
end

# replace POLITICO default images
def replace_politico_article_images
  pol_imgs = Article.all.select {|a| a.urlToImage == "https://static.politico.com/da/f5/44342c424c68b675719324b1106b/politico.jpg"}
  
  url = "https://picsum.photos/450"

  pol_imgs.each do |img|
      response = RestClient.get(url)    
      id = response.headers[:picsum_id]
      
      # parse response string into parsed_string
      parsed_url = "https://i.picsum.photos/id/#{id}/300/200.jpg"

      img.update(urlToImage: parsed_url)
  end
end

# add ratings!
def populate_ratings
  options = Array.new(11) {|i| (i - 5).to_s }

  2000.times do
    user = User.all.sample
    author = Author.all.sample
    likeability = options.sample
    integrity = options.sample

    Rating.create(user_id: user.id, author_id: author.id, likeability: likeability, integrity: integrity)

  end
end