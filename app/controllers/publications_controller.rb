class PublicationsController < ApplicationController

    def index
        publications = Publication.all 
        render json: publications
    end

    def show 
        publication = Publication.find(params[:id])
        render json: publication
    end
end
