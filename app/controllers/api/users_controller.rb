class Api::UsersController < ApiController
  def index
    users = User.all
    render json: users, each_serializer: UserSerializer 
  end

  def create
  	new_user = User.new
    if new_user.save 
      #returns new user from params
      render json: new_user
    else
      #show error message if unsuccessful or lacks a username/password
      render json: { errors: new_user.full_errors }
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

end