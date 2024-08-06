class ArticlesController < ApplicationController
  def show
    @article = Article.find(params[:id])
  end

  def index
    @articles = Article.all
  end


  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    # render plain: params[:article]
    @article = Article.new(params.require(:article).permit(:title, :description))
    # render plain: @article.inspect
    if @article.save
      flash[:notice] = "Article was created successfuly."
      redirect_to @article
    else
      render "new", status: :unprocessable_entity
    end
    # redirect_to article_path(@article) #the same <as></as>
  end


  def update
    @article = Article.find(params[:id])
    if @article.update(params.require(:article).permit(:title, :description))
      flash[:notice] = "Article was updated succesfully!"
      redirect_to @article
    else
      render "edit", status: :unprocessable_entity
    end
  end
end
