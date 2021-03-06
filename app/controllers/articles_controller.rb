class ArticlesController < ApplicationController
    before_action :set_article, only: [:edit,:show,:update,:destroy]
    before_action :require_user, except: [:index, :show]
    before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @articles = Article.paginate(page: params[:page], per_page: 3)
  end

  def new
    @article= Article.new
  end

  def create
    #render plain: params[:article].inspect
    @article= Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:success]= "The article was created successfully"
      redirect_to article_path(@article)
    else
      render 'new'
      #redirect_to_article_path(@article)
    end
  end

  def edit
  end

  def update
    if @article.update(article_params)
      flash[:success]= "The article was Updated successfully"
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end


  def destroy
    @article.destroy
      flash[:danger]= "The article was Deleted successfully"
        redirect_to articles_path
  end

  def show
  end


  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description, category_ids:[])
  end

  def require_same_user
    if current_user!=@article.user and !current_user.admin?
      flash[:danger] ="You can delete or edit only your own article"
      redirect_to root_path
    end
  end
end
