class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    #@movies = Movie.all
@movies= Movie.order(sort_column + " "+ sort_direction)

if params[:sort]=="title"
	@title_header="hilite"
   elsif params[:sort]=="release_date"
	@release_date_header="hilite"
end

@all_ratings = Movie.ratings
if(params[:ratings] == nil)
@selected_ratings = @all_ratings
else
@selected_ratings = params[:ratings].keys
end
if(params[:sort] != nil)
@movies = Movie.where(:rating =>@selected_ratings).order(params[:sort])
else
@movies = Movie.where(:rating =>@selected_ratings)
end
end

def sort_column
 Movie.column_names.include?(params[:sort]) ? params[:sort] : "title"
end

def sort_direction
 %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
end

def new
# default: render 'new' template
end

def create
@movie = Movie.create!(params[:movie])
flash[:notice] = "#{@movie.title} was successfully created."
redirect_to movies_path
end

def edit
@movie = Movie.find params[:id]
end

def update
@movie = Movie.find params[:id]
@movie.update_attributes!(params[:movie])
flash[:notice] = "#{@movie.title} was successfully updated."
redirect_to movie_path(@movie)
end

def destroy
@movie = Movie.find(params[:id])
@movie.destroy
flash[:notice] = "Movie '#{@movie.title}' deleted."
redirect_to movies_path
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

end
