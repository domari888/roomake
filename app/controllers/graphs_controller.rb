class GraphsController < ApplicationController
  def index
    @tags_count_graph = Tag.joins(:post_tags).group(:name).order(count_all: :desc).count
    @categories_count_graph = Category.joins(:post_categories).group(:name).order(count_all: :desc).count
    @likes_count_graph = User.joins(:likes).group(:name).order(count_all: :desc).count
    @likes_average_graph = User.joins(:posts).group(:name).order(average_likes_count: :desc).average(:likes_count)
  end
end
