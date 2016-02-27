class BorrowersController < ApplicationController
	def create
		user = Borrower.new(user_params)
		if user.valid? == true
			user.save
			session[:user_id] = user.id
			redirect_to "/borrowers/%d" % user.id
		else
			flash[:errors] = user.errors.full_messages
			redirect_to "/lenders/index"
		end
	end
	def show
		@borrower = Borrower.find(session[:user_id])
		@lenders = @borrower.historys
	end

	private
	def user_params
		params.require(:borrower).permit(:first_name, :last_name, :email, :password, :password_confirmation, :purpose, :description,:money)
	end
	
end
