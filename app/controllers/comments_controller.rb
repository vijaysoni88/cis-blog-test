# Comment controller for create and destroy article comment
class CommentsController < ApplicationController
  before_action :get_article, only: [:create, :destroy]

  # Create action for create article comment.
  def create
    @comment = @article.comments.build(comment_params)
    @comment.user_id = current_user.id if current_user.present?
     respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment, notice: t('post.notify.subject' ,  title: @comment.class.name) }
        format.js   {}
      else
        format.html { render :new }
        format.js   {}
      end
    end
  end

 # Delete article comment
  def destroy
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to article_path(@article) }
      format.js
    end
  end
 
  private
    
  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end

  def get_article
    @article = Article.find(params[:article_id])
  end
end
