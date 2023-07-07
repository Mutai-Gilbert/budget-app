# frozen_string_literal: true

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

    respond_to do |format|
      if @entity.save
        format.html { redirect_to group_entities_path, notice: 'Entity was successfully created.' }
        GroupEntity.create!(entity_id: @entity.id, group_id: params[:group_id])
        format.json { render :show, status: :created, location: @entity }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @entity.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @entity.update(entity_params)
        format.html { redirect_to entity_url(@entity), notice: 'Entity was successfully updated.' }
        format.json { render :show, status: ok, location: @entity }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @entity.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @entity.destroy

    respond_to do |format|
      format.html { redirect_to entities_url, notice: 'Entity was successfully desctroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_entity
    @entity = Entity.find(paramsp[:id])
  end

  def entity_params
    params.permit(:name, :amount)
  end
end
