class SearchesController < ApplicationController
  def search
    @model = params[:model]
    @method = params[:method]
    @search = params[:search]
    
    if @model == "user"
      @users = User.search(params[:search], @model, @method)
    else
      @books = Book.search(params[:search], @model, @method)
    end
  end
end
