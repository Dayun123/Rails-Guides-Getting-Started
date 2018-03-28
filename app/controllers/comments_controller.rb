class CommentsController < ApplicationController

  # create a new comment linked to the article that the comment was made from and redirect to the show view for the article so the user can view the article with their comment present.
  def create
    # retrieve the article from the db that this comment was made on. Since we set up nested routes, the URL will have the article_id in it. Ex: articles/:id/comments.
    @article = Article.find(params[:article_id])

    # create the comment and save to the db using the collection.create method that we gain from creating a has_many assocation between articles and comments. We pass in the sanitized params from the form.
    @comment = @article.comments.create(comment_params)

    # redirect the user to the show view for the article that was commented on.
    redirect_to article_path(@article)
  end

  # destroy the comment related to the article from the URL path /articles/:article_id/comments/:id
  def destroy
    # find the associated article that goes with this comment (/articles/:article_id/comments/:id) The only reason we need to query the db here is to get the @article model that the comment will be deleted from so we can call redirect_to on it. We can use the @article.comments.find method or just Comment.find, as both will essentially make the same db call.
    @article = Article.find(params[:article_id])

    # find the comment associated with this article by the comments id. We can use @article.comments.find or Comment.find, both will take the same param and both will make the same SQL call.
    # @comment = @article.comments.find(params[:id])
    @comment = Comment.find(params[:id])

    # destroy the comment
    @comment.destroy

    # redirect the user to the show view for the article the comment was deleted from. Here we just redirect_to the @article instance variable, and Rails knows to go to the show view for the ArticlesController. The style using the named path helper is commented out below.
    redirect_to @article
    # redirect_to article_path(@article)
  end

  private

    # sanitize the parameters that we expect when a form is submitted to create a new comment. We require a comment model which has :commenter and :body attributes.
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end

end
