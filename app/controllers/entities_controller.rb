# Top-level documentation comment for the EntitiesController class
class EntitiesController < ApplicationController
  before_action :authenticate_user!

  def index
    @group = Group.find(params[:group_id])
    @entities = @group.entities
  end

  def show; end

  def new
    @entity = Entity.new
  end

  def edit; end

  def create
    @entity = Entity.new(entity_params.merge(user: current_user))
    respond_with_save(@entity, 'Entity', group_entities_path)
  end

  def update
    respond_with_save(@entity, 'Entity', entity_url(@entity))
  end

  def destroy
    @entity.destroy

    respond_to do |format|
      format.html { redirect_to entities_url, notice: 'Entity was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_entity
    @entity = Entity.find(params[:id])
  end

  def entity_params
    params.permit(:name, :amount)
  end

  def respond_with_save(entity, entity_name, redirect_path)
    respond_to do |format|
      if entity.save
        GroupEntity.create!(entity_id: entity.id, group_id: params[:group_id])
        format.html { redirect_to redirect_path, notice: "#{entity_name} was successfully created." }
        format.json { render :show, status: :created, location: entity }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: entity.errors, status: :unprocessable_entity }
      end
    end
  end
end
