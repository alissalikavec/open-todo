class Api::UsersController < ApiController
  skip_before_filter :verify_authenticity_token, only: [:create]
  def index
    users = User.all
    render json: users, each_serializer: UserSerializer 
  end

  def create
  	new_user = User.new(user_params)
    if new_user.save 
      #returns new user from params
      render json: new_user
    else
      #show error message if unsuccessful or lacks a username/password
      render json: { errors: new_user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:new_user).permit(:username, :password)
  end

end