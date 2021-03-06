class InvoicePdf < Prawn::Document
  include ActionView::Helpers::NumberHelper
  
	def initialize(invoice)
		super(page_layout: :portrait)
		@invoice = invoice
		font "Helvetica"
		font_size 11
		@initial_y = cursor
		@initialmove_y = 5
		@address_x = 14
		@invoice_header_x = 350
		@lineheight_y = 12
		@last_measured_y = cursor
		
		header
    client_info
    invoice_info
    invoice_misc
	end
	

def header
  move_down 20
  logopath = Rails.root.join('app','assets','images','Mitsab_Logo.png').to_s
  text_box "Mitsab Incorporation", :at => [@address_x,  cursor], style: :bold
  move_down @lineheight_y
  text_box "8303 Southwest Freeway, Suite 700", :at => [@address_x,  cursor]
  move_down @lineheight_y
  text_box " Houston, TX 77074", :at => [@address_x,  cursor]
	move_down @lineheight_y
	
  last_measured_y = cursor
  move_cursor_to bounds.height
 
	image logopath, width: 200, position: :right
	move_cursor_to last_measured_y
end

 def client_info
	move_down 65
  @last_measured_y = cursor

  text_box "BILL TO", :at => [@address_x, cursor], style: :bold
  move_down @lineheight_y
  text_box "#{@invoice.customer.try(:cus_fullname)}", :at => [@address_x,  cursor]
  move_down @lineheight_y
  text_box "#{@invoice.customer.address}", :at => [@address_x,  cursor]
  move_down @lineheight_y
	text_box "Houston, TX 70004", :at => [@address_x,  cursor]
	
	move_cursor_to @last_measured_y

	  invoice_header_data = [ 
    ["Invoice #", "#{@invoice.invoicenum}"],
    ["Date", "#{@invoice.invoicedate.to_s(:med_date)}"],
    ["Due Date", "#{@invoice.duedate.to_s(:med_date)}"],
		["Terms", "Net 30"]]
		

		table(invoice_header_data, :position => @invoice_header_x, :width => 180) do
    style(row(0..3).columns(0..1), :padding => [1, 5, 1, 5], :borders => [])
    style(column(1), :align => :right)
    style(column(0), :font_style => :bold)
     end
    move_down 24
end

def invoice_info
  stroke do
    stroke_color 'dddddd'
    stroke_horizontal_rule
  end
  move_down 36

  invoice_services_data = [ 
    ["Item", "Description", "Quantity", "Rate", "Amount Due"],
    ["Service Name", "Service Description", "100", "#{number_to_currency(@invoice.amountdue)}", "#{number_to_currency(@invoice.amountdue)}"],
    [" ", " ", " ", " ", " "]
  ]

  table(invoice_services_data, :width => bounds.width) do
    style(row(1..-1).columns(0..-1), :padding => [4, 5, 4, 5], :borders => [:bottom], :border_color => 'dddddd')
    style(row(0), :background_color => 'e9e9e9', :border_color => 'dddddd', :font_style => :bold)
    style(row(0).columns(0..-1), :borders => [:top, :bottom])
    style(row(0).columns(0), :borders => [:top, :left, :bottom])
    style(row(0).columns(-1), :borders => [:top, :right, :bottom])
    style(row(-1), :border_width => 2)
    style(column(3..-1), :align => :right)
    style(columns(0), :width => 80)
    style(columns(1), :width => 260)
  end


  move_down 1

  invoice_services_totals_data = [ 
    ["Total", "$3,200.00"],
    ["Amount Paid", "-0.00"],
    ["Amount Due", "$3,200.00 USD"]
  ]
  table(invoice_services_totals_data, :position => @invoice_header_x, :width => 190) do
    style(row(0..1).columns(0..1), :padding => [1, 5, 1, 5], :borders => [])
    style(row(0), :font_style => :bold)
    style(row(2), :background_color => 'e9e9e9', :border_color => 'dddddd', :font_style => :bold)
    style(column(1), :align => :right)
    style(row(2).columns(0), :borders => [:top, :left, :bottom])
    style(row(2).columns(1), :borders => [:top, :right, :bottom])
  end

end

 def invoice_misc
  move_down 20

  invoice_notes_data = [ 
    ["Thank you for doing business with Mitsab Incorporation!"]
  ]

  table(invoice_notes_data, :position => 370, :width => 170) do
    style(row(0..-1).columns(0..-1), :padding => [1, 0, 1, 0], :borders => [], :font__style => :bold, :align => :right)
    #style(row(0).columns(0), :font_style => :bold)
 end
end


end