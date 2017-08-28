class LocationsController < ApplicationController

  before_action :set_locations, only: [:show, :edit, :update, :destroy]

  def index
    @locations = Location.all
  end

  def new
    @location = Location.new
  end

  def import
    Location.import(params[:file])
    redirect_to root_url, notice: "activity data imported!"
  end

  def json_import
    Location.import(params[:file])
    redirect_to root_url, notice: "JSON data imported!"
  end

  def show
     @location = Location.find(params[:id])
  end

  def destroy
    @location.destroy

    redirect_to locations_path
  end

  def update

    if @location.update(location_params)
      redirect_to @location
    else
      render 'edit'
    end
  end

  def edit
  end

  def create
     @location = Location.new(location_params)

    if @location.save
      flash[:success] = "Location added!"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def find_map
    @location = Location.find(params[:id])
    lat = @location.latitude
    long = @location.longitude
    @locations = Location.near([lat , long],50, unit: :km)
  end
 private

    def location_params
      params.require(:location).permit(:name, :state, :city, :district, :zip_code, :about, :image, :latitude, :longitude, images_attributes:[:id, :image, :imageable_type, :imageable_id, :_destroy , :remove_image])
    end
    def set_locations
        @location = Location.find(params[:id])
    end

end
