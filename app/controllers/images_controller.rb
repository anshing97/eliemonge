class ImagesController < ApplicationController

  def show
    @image = Image.find(params[:id])
  end

  def new
    @image = Image.new
  end


  def create
    @image = Image.new(params[:image])

    if @image.save
      redirect_to controller: "search", img_url: @image.image.url(:large).split('?').first
    end 
  end
end
