class AuthorsController < ApplicationController
    def index 
        authors = Author.all 
        render json: authors, each_serializer: AuthorSerializer    
    end

    def show
        author = Author.find(params[:id])
        render json: author, serializer: ShowAuthorSerializer
    end

    def update
        # byebug
        author = Author.find(params[:id])
        author.update(author_params)
        render json: author, serializer: ShowAuthorSerializer
    end

    private

    def author_params
        params.require(:author).permit(:image, :twitter)
    end
end
