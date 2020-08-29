# Article controller for creating an article of user
class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :destroy]

  # List of articles.
  def index
    @articles = Article.all
  end

  # Show article.
  def show
  end

  # Initialize new article.
  def new
    @article = Article.new
  end

 # Creating an article.
  def create
    @article = current_user.articles.build(article_params) if current_user.present?
    if @article.save
      redirect_to @article, notice: t('post.notify.subject', title: @article.class.name)
    else
      render 'new'
    end
  end

 # Delete an article.
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_path }
      format.js
    end
  end

  private
  # Only allow a list of trusted parameters through.
  def article_params
    params.require(:article).permit(:title, :text)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = Article.find(params[:id])
  end
end
