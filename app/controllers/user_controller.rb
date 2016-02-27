class UserController < ApplicationController
	def index

	end
	def create
		user = Lender.find_by(email: params["user"][:email])
		if user
			if user && user.authenticate(params["user"][:password])
				session[:user_id]= user.id
				session[:user_name] = user.first_name
				session[:money] = user.money
				redirect_to "/lenders/%d" % user.id
			else
				flash[:error] = "Invalid"
				redirect_to "/"
			end
		else
			user = Borrower.find_by(email: params["user"][:email])
			if user
				if user && user.authenticate(params["user"][:password])
					session[:user_id]= user.id
					session[:user_name] = user.first_name
					redirect_to "/borrowers/%d" % user.id
				else
					flash[:error] = "Invalid"
					redirect_to "/"
				end
			end
		end
	end

	def destroy
		session.clear
		redirect_to "/"
	end
end
