# This file is app/controller/movies_controller.rb

class MoviesController < ApplicationController

  helper_method :sort_column, :sort_direction
  def index
    @all_ratings = Movie.all_ratings  # just to make data accessible to views
    @movies = Movie.search(params).order(sort_column + " " + sort_direction)
  end

  def sort_column
    Movie.column_names.include?(params[:sort]) ? params[:sort] : "title"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def movies_with_filters
    @movies = Movie.with_good_reviews(params[:threshold])
    %w(for_kids with_many_fans recently_reviewed).each do |filter|
      @movies = @movies.send(filter) if params[filter]
    end
  end

  def search_tmdb
    flash[:warning] = "'#{params[:search_terms]}' was not found in TMDb."
    @movies = Movie.find_in_tmdb(params[:search_terms])
    redirect_to movies_path if @movies.empty?
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    begin
      @movie = Movie.find(id) # look up movie by unique ID
      render(:partial => 'movie', :object => @movie) if request.xhr?
      # will render app/views/movies/show.html.haml by default
    rescue
      flash[:warning] = "Movie with ID #{id.to_s} was not found."
      redirect_to movies_path
    end
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(params[:movie])
    if @movie.save
      flash[:notice] = "#{@movie.title} was successfully created."
      redirect_to movies_path
    else
      render 'new' # note, 'new' template can access @movie's field values
    end
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    if @movie.update_attributes(params[:movie])
      flash[:notice] = "#{@movie.title} was successfully updated."
      redirect_to movie_path(@movie)
    else
      render 'edit' # note: 'edit' template can access @movie's field values
    end
  end

  def destroy
    @movie = Movie.find params[:id]
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
