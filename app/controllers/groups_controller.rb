class GroupsController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update]

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      @group.group_users.create(user_id: current_user.id)
      redirect_to groups_path
    else
      render :new
    end
  end

  def join
    @group = Group.find(params[:group_id])
    @group.group_users.create(user_id: current_user.id)
    redirect_to groups_path
  end

  def destroy
    group = Group.find(params[:id])
    join = group.group_users.find_by(user_id: current_user.id)
    join.destroy
    redirect_to groups_path
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

  def new_mail
    @group = Group.find(params[:group_id])
  end

  def send_mail
    @group = Group.find(params[:group_id])
    users = @group.users
    @title = params[:title]
    @content = params[:content]
    GroupMailer.event_email(users, @title, @content).deliver
    redirect_to group_send_mail_path(@group)
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
