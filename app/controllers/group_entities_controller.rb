# frozen_string_literal: true

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

    respond_to do |format|
      if @group_entity.save
        format.html do
          redirect_to group_entity_url(@group_entity), notice: 'Group entity was successfully created.'
        end
        format.json { render :show, status: :created, location: @group_entity }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @group_entity.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @group_entity.update(group_entity_params)
        format.html do
          redirect_to group_entity_url(@group_entity), notice: 'Group entity was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @group_entity }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @group_entity.errors, status: :unprocessable_entity }
      end
    end
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
    params.fetch(:group_entity, {})
  end
end
