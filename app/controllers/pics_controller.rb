class PicsController < ApplicationController
  before_action :set_pic, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  respond_to :html

  def index
    @pics = Pic.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 1)
    respond_with(@pics)
  end

  def show
    respond_with(@pic)
  end

  def new
    @pic = current_user.pics.build
    respond_with(@pic)
  end

  def edit
  end

  def create
    @pic = current_user.pics.build(pic_params)
    @pic.save
    respond_with(@pic)
  end

  def update
    @pic.update(pic_params)
    respond_with(@pic)
  end

  def destroy
    @pic.destroy
    respond_with(@pic)
  end

  private
    def set_pic
      @pic = Pic.find(params[:id])
    end

    def correct_user
      @pic = current_user.pics.find_by(id: params[:id])
      redirect_to pics_path, notice: "Not authorized to edit this pic" if @pic.nil?
    end

    def pic_params
      params.require(:pic).permit(:description, :image)
    end
end
