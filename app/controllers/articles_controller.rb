class ArticlesController < ApplicationController

  def new
    @article= Article.new
  end

  def create
    #render plain: params[:article].inspect
    @article= Article.new(article_params)
    if @article.save
      flash[:notice]= "The article was created successfully"
      redirect_to article_path(@article)

    else
      render 'new'
      #redirect_to_article_path(@article)
    end
  end

  def show
    @article= Article.find(params[:id])
  end

  private

  def article_params
    params.require(:article).permit(:title, :description)

  end
end
