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

  private

    # sanitize the parameters that we expect when a form is submitted to create a new comment. We require a comment model which has :commenter and :body attributes.
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end

end
