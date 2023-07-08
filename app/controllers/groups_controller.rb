# Top-level documentation comment for the GroupsController class
class GroupsController < ApplicationController
  before_action :authenticate_user!

  def index
    @groups = Group.where(user_id: current_user.id)
  end

  def show
    @group = Group.find(params[:id])
  end

  def new
    @group = Group.new
  end

  def edit; end

  def create
    @group = Group.new(group_params.merge(user_id: current_user.id))

    respond_to do |format|
      if @group.save
        handle_successful_group_creation(format)
      else
        handle_failed_group_creation(format)
      end
    end
  end

  private

  def handle_successful_group_creation(format)
    format.html { redirect_to groups_path, notice: 'Group was successfully created.' }
    format.json { render :show, status: :created, location: @group }
  end

  def handle_failed_group_creation(format)
    format.html { render :new, status: :unprocessable_entity }
    format.json { render json: @group.errors, status: :unprocessable_entity }
  end

  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to groups_path, notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @group.destroy

    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name, :icon)
  end
end
