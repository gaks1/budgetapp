class EntitiesController < ApplicationController
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
  def edit; end

  # POST /entities or /entities.json
  def create
    @group = Group.find(params[:group_id])
    @entity = Entity.new(entity_params)
    @entity.author = current_user
    @entity.entity_groups.build(group: @group)

    if @entity.save
      redirect_to group_path(@group), notice: 'Entity was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /entities/1 or /entities/1.json
  def update
    respond_to do |format|
      if @entity.update(entity_params)
        format.html { redirect_to entity_url(@entity), notice: 'Entity was successfully updated.' }
        format.json { render :show, status: :ok, location: @entity }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @entity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entities/1 or /entities/1.json
  def destroy
    @entity = Entity.find(params[:id])
    @group = Group.find(params[:group_id])

    @entity.destroy
    redirect_to group_path(@group), notice: 'Entity was successfully destroyed.'
  end



  private

  # Only allow a list of trusted parameters through.
  def entity_params
    params.require(:entity).permit(:name, :amount, entity_groups_attributes: [:group_id])
  end
end
