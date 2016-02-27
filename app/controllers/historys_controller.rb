class HistorysController < ApplicationController
	def create
		z = params[:amount].to_i
		if session[:money]-session[:lend_balance] - z < 0
			flash[:no_money] = "Insufficient Funds"

		else
			History.create(amount: params[:amount], lender: Lender.find(session[:user_id]), borrower: Borrower.find(params[:id]))
			borrower = Borrower.find(params[:id]).update(raised: Borrower.find(params[:id]).raised + z)
		end
		redirect_to '/lenders/%d' % session[:user_id]

		
	end
end
