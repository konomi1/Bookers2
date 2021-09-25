class GroupsController < ApplicationController
  before_action :ensure_correct_user, only: [:edit]

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to groups_path
    else
      render :new
    end
  end

  def show
    @group = Group.find(params[:id])
  end

  def index
    @groups = Group.all
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to groups_path
    else
      render :edit
    end
  end

  private
  def group_params
    params.require(:group).permit(:name, :introduction, :image, :owner_id)
  end

  def ensure_correct_user
    group = Group.find(params[:id])
	  unless group.owner_id != current_user
	    redirect_to groups_path
	  end
  end
end
