class EntitiesController < ApplicationController
  before_action :set_entity, only: %i[ show edit update destroy ]

  # GET /entities or /entities.json
  def index
    @entities = Entity.all
  end

  # GET /entities/1 or /entities/1.json
  def show
    @entity = Entity.find(params[:id])
    @group = Group.find(params[:group_id])
  end

  # GET /entities/new
  def new
    @group = Group.find(params[:group_id])
    @entity = Entity.new
  end

  # GET /entities/1/edit
  def edit
  end

  # POST /entities or /entities.json
  def create
    @group = Group.find(params[:group_id])
    @entity = Entity.new(entity_params)
    @entity.author = current_user
    @entitygroup = EntityGroup.new
    @entitygroup.group = @group
    @entitygroup.entity = @entity

    if @entity.save && @entitygroup.save
      redirect_to group_path(@group), notice: "Entity was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /entities/1 or /entities/1.json
  def update
    respond_to do |format|
      if @entity.update(entity_params)
        format.html { redirect_to entity_url(@entity), notice: "Entity was successfully updated." }
        format.json { render :show, status: :ok, location: @entity }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @entity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entities/1 or /entities/1.json
  def destroy
    @group = Group.find(params[:group_id])
    @entity.destroy

    respond_to do |format|
      format.html { redirect_to group_path(@group), notice: "Entity was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entity
      @entity = Entity.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def entity_params
      params.require(:entity).permit(:name, :amount)
    end
end
