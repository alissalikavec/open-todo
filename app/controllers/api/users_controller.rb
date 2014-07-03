class Api::UsersController < ApiController
  def index
    users = User.all
    render json: users, each_serializer: UserSerializer 
  end

  def create
  	new_user = User.new(user_params)
    if new_user.save 
      #returns new user from params
    else
      #show error message if unsuccessful or lacks a username/password
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

end