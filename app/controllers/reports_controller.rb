class ReportsController < ApplicationController
	def active_orders
		@active_orders = ActiveOrder.all

		respond_to do |format|
			format.html
			format.pdf do
				pdf = ActiveOrderPdf.new(@active_orders)
				send_data pdf.render,
				filename: "Active_Orders_" + Date.today.to_s(:num_date) + ".pdf",
				type: "application/pdf",
				disposition: "inline"
			end
		end
            
	end

	def active_invoices
    	@active_invoices = ActiveInvoice.all
	end

	def auction_orders
    	@auction_orders = AuctionOrder.all
	end
	
end