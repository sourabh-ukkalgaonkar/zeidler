# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :authorize_user, except: :index
  before_action :find_article, only: %i[edit update destroy]

  def index
    @articles = Article.search(params[:search], current_user).distinct.paginate(per_page: 25, page: params[:page])
  end

  def new
    @article = Article.new
    @categories = Category.all
  end

  def create
    ActiveRecord::Base.transaction do
      categories = Category.where(id: params[:category_ids])
      @article = current_user.articles.create!(article_params)

      @article.categories << categories
    end
    redirect_to articles_path
  rescue StandardError => e
    @categories = Category.all
    render :new
  end

  def edit
    @categories = Category.all
  end

  def update
    if @article.update(article_params)
      redirect_to articles_path
    else
      render :new
    end
  end

  def destroy
    @article.destroy
    redirect_to root_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :text, :status)
  end

  def find_article
    @article = current_user.articles.where(id: params[:id]).first
    redirect_to root_path if @article.blank?
  end
end
