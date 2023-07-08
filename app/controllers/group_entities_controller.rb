# Top-level documentation comment for the GroupEntitiesController class
class GroupEntitiesController < ApplicationController
  before_action :authenticate_user!

  def index
    @group_entities = GroupEntity.all
  end

  def show; end

  def new
    @group_entity = GroupEntity.new
  end

  def edit; end

  def create
    @group_entity = GroupEntity.new(group_entity_params)
    respond_with_save(@group_entity, 'Group entity', group_entity_url(@group_entity))
  end

  def update
    respond_with_save(@group_entity, 'Group entity', group_entity_url(@group_entity))
  end

  def destroy
    @group_entity.destroy
    respond_to do |format|
      format.html { redirect_to group_entities_url, notice: 'Group entity was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_group_entity
    @group_entity = GroupEntity.find(params[:id])
  end

  def group_entity_params
    params.require(:group_entity, {})
  end

  def respond_with_save(entity, entity_name, redirect_path)
    respond_to do |format|
      if entity.save
        format.html { redirect_to redirect_path, notice: "#{entity_name} was successfully created." }
        format.json { render :show, status: :created, location: entity }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: entity.errors, status: :unprocessable_entity }
      end
    end
  end
end
