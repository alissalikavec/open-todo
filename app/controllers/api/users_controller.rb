class Api::UsersController < ApiController
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
      #http://futureshock-ed.com/2011/03/04/http-status-code-symbols-for-rails/
      #http://api.rubyonrails.org/classes/ActiveModel/Errors.html#method-i-full_message
    end
  end

  private

  def user_params
    params.require(:new_user).permit(:username, :password)
  end

end