class ArticlesController < ApplicationController

  # we want users to be authenticated on every action except the index and show actions. If we didn't do this, anyone could come in and create, edit, or destroy articles.
  http_basic_authenticate_with name: "admin", password: "pass123", except: [:index, :show]


  # the index action will retrieve all of the Articles from the db and pass them to the view in the @articles instance variable.
  def index
    @articles = Article.all
  end

  # the show action will use the id parameter passed in the url (article/:id) to retreive the specified Article from the db and pass it to the view as the @article instance variable. For ex. the request GET /article/1 would result in the params[:id] == params[1] and the Article with the id of 1 being pulled from the db.
  def show
    @article = Article.find(params[:id])
  end

  def new
    # we need an @article instance variable to be associated with the 'new' view, so this takes care of that for us. Mainly, this is for error handling in the 'create' action when we call the 'render :new' on validation errors. Without creating an @article instance variable here, the validation error messages wouldn't be able to be displayed.
    @article = Article.new
  end

  def edit
    # retrieve the Article from the db that has the param of the id passed from the URL. Ex. articles/3/edit would retrieve the article with the id of 3 and pass it along to the edit view in the @article instance variable.
    @article = Article.find(params[:id])
  end

  def create
    # create an @article attribute variable and initialize it to the new article from the params that come in from the form. We use the private method article_params to make sure we are only getting params related to the article and that they are the exact attributes of the article we expect.
    @article = Article.new(article_params)

    # save the @article to the db
    if @article.save
      # redirect to the show view for this article using the shorthand @article which is the same as article_path(@article)
      redirect_to @article
    else
      # if the article was somehow invalid, we want to use render to render the new view again, and this will re-populate the form with the parameters sent in the last request. We don't use redirect_to because that will allow the user to possibly re-submit the previous POST data again if they refresh the browser. The render method is also used so that the @article object is passed back in to the new view.
      render :new
    end
  end

  def update
    # find the article we will be updating from the id passed in from the url in the param
    @article = Article.find(params[:id])

    # attempt to update the @article will pulled from the db with the attributes we got from the form submission.
    if @article.update(article_params)
      # if the article updated successfully, redirect to the show view for this article.
      redirect_to @article
    else
      # if for some reason updating the article failed, render the edit view but don't cause a redirect as this could allow users to re-post form data if they refresh the browser.
      render :edit
    end
  end

  def destroy
    # find the Article associated with the id passed in from the url in the params hash
    @article = Article.find(params[:id])

    # destroy the article
    @article.destroy

    # redirect to the index action
    redirect_to articles_path
  end

  # anything below the 'private' keyword will only be available to this class
  private

    # create a method that sanitizes the params coming in related to the article object.
    def article_params
      # we want to require that the params contain the article information, and we will only permit title and text attributes for that article.
      params.require(:article).permit(:title, :text)
    end

end
