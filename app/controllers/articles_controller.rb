class ArticlesController < ApplicationController
rescue_from ActiveRecord::InvalidForeignKey, with: :foreign_key_violation
before_action :set_article_id, only: %i[show edit update destroy]
def index
  @articles = Article.all
end
def show
  @articles_comments = @article.comments
end
def new
  @article = Article.new
end
def create
  @article = Article.new(article_params)
  if @article.save
    redirect_to @article, notice: 'An article has been created.'
  else
    render :new, status: :unprocessable_entity, alert: 'Failed to create an article.'
  end
end
def edit; end
def update
  if @article.update(article_params)
    redirect_to @article
  else
    render :edit, status: :unprocessable_entity
  end
end
def destroy
  if @article.destroy
    redirect_to articles_path, notice: 'Record has been deleted.'
  else
    redirect_to root_path, status: :see_other, alert: 'Failed to delete a record.'
  end
end
private
def article_params
  params.require(:article).permit(:title, :body)
end
def foreign_key_violation
  @article = Article.find(params[:id])
  redirect_to article_path(@article), alert: 'Record cannot be deleted. A comments is still references on it.'
end
def set_article_id
  @article = Article.find(params[:id])
end
end