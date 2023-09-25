class PhotosController < ApplicationController
  def index
    @all_photos = Photo.all
  end

  def show
    @photo = Photo.find(params[:id])
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(photo_params)

    respond_to do |format|
      if @photo.save
        format.html { redirect_to photo_url(@photo), notice: "Photo was successfully created." }
        format.json { render :show, status: :created, location: @photo }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def photo_params
    params.require(:photo).permit(:photo_file)
  end
end
