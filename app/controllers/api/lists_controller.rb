class Api::ListsController < ApiController
  before_action :set_user
  before_action :set_list, only: [:show, :edit, :update, :destroy]

  def show
    items = @list.items
    render json: items, each_serializer: ItemSerializer #using ItemSerializer because we want to show a list's items
  end

  def new
    list = List.new
    authorize list
  end

  def edit
    @list
    authorize @list
    #edit lists with permissions set to 'open'
    #view lists with permissions set to 'viewable'
  end

  def index
    lists = @user.lists
    authorize lists
  end

  def create
    list = List.new(list_params)
    list.user_id = @user.id
    authorize list
    if list.save
      render json: ListSerializer.new(list).to_json
    else
      render json: { errors: list.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    authorize list
    if list.update(list_params)
      redirect_to user_list_path(@user, @list), notice: 'List was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    list.destroy
    redirect_to @user
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_list
    @list = List.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:name, :user_id)
  end
end
