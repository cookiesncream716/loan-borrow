class LendersController < ApplicationController
	def create
		user = Lender.new(user_params)
		if user.valid? == true
			user.save
			session[:user_id] = user.id
			session[:money] = user.money
			redirect_to "/lenders/%d" % user.id
		else
			flash[:errors] = user.errors.full_messages
			redirect_to "/lenders/index"
		end
	end
	def show
		@lender = Lender.find(session[:user_id])
		@borrowers = Borrower.all
		@lent = Lender.find(session[:user_id]).historys.sum("amount")
		session[:lend_balance] = @lent
		@loaned = Lender.find(session[:user_id]).historys
	end



private
	def user_params
		params.require(:lender).permit(:first_name, :last_name, :email, :password, :password_confirmation, :money)
	end
end	