class AuthorsController < ApplicationController
	def index
		@authors = Author.all
	end

	def show
		@author = Author.find(params[:id])
        #require 'pry'; binding.pry
    end

    def new
    	@author = Author.new
    end

    def edit
    	 @author = Author.find(params[:id])
    end

    def create
       #require 'pry'; binding.pry
       @author = Author.create(author_params)
       if @author.save
       	flash[:success] = "Author has been created"
         redirect_to author_path(@author)
       else
       	flash[:alert] = "Author has not been created"
         render :new
       end
    end 
    def update
    	@author = Author.find(params[:id])
    	if @author.update_attributes(author_params)
        	flash[:success] = "Author has been updated"
    	   redirect_to @author
        else
        	flash[:alert]  = "Author has not be updated"
        	render :edit
        end
    end

    def destroy
    @author = Author.find(params[:id])
    if @author.destroy
      flash[:success] = "Author has been deleted."
      redirect_to authors_path
    end
  end
    private 
    def author_params
    	params.require(:author).permit(:first_name, :last_name)
    end
end
