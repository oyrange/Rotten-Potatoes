class MoviesController < ApplicationController

    def show
      id = params[:id] # retrieve movie ID from URI route
      @movie = Movie.find(id) # look up movie by unique ID
      # will render app/views/movies/show.<extension> by default
    end

    def index
      @all_ratings = Movie.possible_ratings

      if params[:sort] or params[:ratings]
        @ratings_to_show = params[:ratings] ? params[:ratings].keys : @all_ratings
        @sort_column = params[:sort] or session[:sort]

        ## update session cookies
        session[:sort] = @sort_column
        session[:ratings] = @ratings_to_show
      else
        @ratings_to_show = session[:ratings] ? session[:ratings] : @all_ratings
        @sort_column = session[:sort]
      end
      @movies = Movie.get_movies_rated(@ratings_to_show)
      @movies = @movies.order(@sort_column) if @sort_column

      @title_sort_header = 'hilite bg-warning' if @sort_column == 'title'
      @release_date_sort_header = 'hilite bg-warning' if @sort_column == 'release_date'
    end

    def new
      # default: render 'new' template
    end

    def create
      @movie = Movie.create!(movie_params)
      flash[:notice] = "#{@movie.title} was successfully created."
      redirect_to movies_path
    end

    def edit
      @movie = Movie.find params[:id]
    end

    def update
      @movie = Movie.find params[:id]
      @movie.update_attributes!(movie_params)
      flash[:notice] = "#{@movie.title} was successfully updated."
      redirect_to movie_path(@movie)
    end

    def destroy
      @movie = Movie.find(params[:id])
      @movie.destroy
      flash[:notice] = "Movie '#{@movie.title}' deleted."
      redirect_to movies_path
    end

    private
    # Making "internal" methods private is not required, but is a common practice.
    # This helps make clear which methods respond to requests, and which ones do not.
    def movie_params
      params.require(:movie).permit(:title, :rating, :description, :release_date)
    end
  end
