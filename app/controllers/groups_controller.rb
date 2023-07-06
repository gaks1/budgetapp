class GroupsController < ApplicationController
  # GET /groups or /groups.json
  def index
    @groups = current_user.groups
    @totalamount = {}
    @groups.each do |group|
      grouptotal = 0
      group.entities.each do |entity|
        grouptotal += entity.amount
      end
      @totalamount[group.id] = grouptotal
    end
  end

  # GET /groups/1 or /groups/1.json
  def show
    @group = Group.find(params[:id])
    @entities = @group.entities.order(created_at: :desc)
    @totalamount = {}
    grouptotal = 0
    @entities.each do |entity|
      grouptotal += entity.amount
    end
    @totalamount[@group.id] = grouptotal
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit; end

  # POST /groups or /groups.json
  def create
    @group = Group.new(group_params)
    @group.user = current_user

    if @group.save
      redirect_to groups_path, notice: 'Group was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /groups/1 or /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to group_url(@group), notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1 or /groups/1.json
  def destroy
    @group = Group.find(params[:id])
    @group.destroy

    redirect_to groups_path, notice: 'Group was successfully destroyed.'
  end

  private

  # Only allow a list of trusted parameters through.
  def group_params
    params.require(:group).permit(:name, :icon)
  end
end
