class Api::ItemsController < ApiController
  before_action :set_item, only: [:show, :update, :destroy]
  before_action :set_list

  def create
    if @list.add(item_params[:description])
      render json: item
    else
      render json: { errors: item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def new
    @item = Item.new
  end

  def destroy
    @item.mark_complete
    # Not quite sure what json to render here
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def set_list
    @list = @item ? @item.list : List.find(params[:list_id])
  end

  def item_params
    params.require(:item).permit(:description, :list_id, :completed)
  end
end
