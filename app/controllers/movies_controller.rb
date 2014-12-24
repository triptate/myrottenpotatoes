# This file is app/controller/movies_controller.rb

class MoviesController < ApplicationController

  def index
    @all_ratings = Movie.all_ratings  # just to make data accessible to view

    # if a new filter is added, use it and update the session; otherwise, use the session or the default
    if params[:filter]
      @filter = params[:filter].keys
      session[:filter] = params[:filter]
    else
      @filter = session[:filter] ? session[:filter].keys : @all_ratings      
    end

    # if a new sort is added, use it and update the session; otherwise, use the session or the default
    if params[:sort]
      @sort = session[:sort] = params[:sort]
    else
      @sort = session[:sort] ? session[:sort] : :title
    end

    @sort = @sort.to_sym  # params and session will convert the sort to a string, causing CSS issues
    @movies = Movie.where(rating: @filter).order(@sort)
  end

  def movies_with_filters
    @movies = Movie.with_good_reviews(params[:threshold])
    %w(for_kids with_many_fans recently_reviewed).each do |filter|
      @movies = @movies.send(filter) if params[filter]
    end
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    begin
      @movie = Movie.find(id) # look up movie by unique ID
      render(:partial => 'movie_details', :object => @movie) if request.xhr?
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
      redirect_to movie_path(@movie)
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
