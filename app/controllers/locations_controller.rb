class LocationsController < ApplicationController

  before_action :set_locations, only: [:show, :edit, :update, :destroy]

  def index
    @locations = Location.all
  end

  def new
    @location = Location.new
  end

  def show
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
      redirect_to @location
    else
      render 'new'
    end
  end
 private

    def location_params
      params.require(:location).permit(:name, :state, :city, :district, :zip_code, :about, :image, images_attributes:[:id, :image, :imageable_type, :imageable_id, :_destroy , :remove_image])
    end
    def set_locations
        @location = Location.find(params[:id])

    end

end
