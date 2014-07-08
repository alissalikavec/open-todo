class ApiController < ApplicationController
	private
	def authenticated?
    	authenticate_with_http_basic {|user, pass| User.where( username: user, password: pass).present? }
	end

  	def check_auth
    	return permission_denied_error unless authenticated?
  	end
end