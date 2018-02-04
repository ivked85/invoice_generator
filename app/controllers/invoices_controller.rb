class InvoicesController < ApplicationController
  before_action :find_invoice, only: [:show, :destroy]
  
  def index
    @invoices = Invoice.all
  end
  
  def new
    @invoice = Invoice.new
  end
  
  def create
    @invoice = Invoice.create(invoice_attributes)
    @invoice.save
    redirect_to @invoice
  end
  
  def show
  end
  
  def destroy
    @invoice.destroy
    redirect_to @invoice
  end
  
  def invoice_attributes
    params.require(:invoice).permit(:unit_price_eur, :workdays_total, :date,
                                    :invoice_template_id, :workdays, :number)
  end
  
  def find_invoice
    @invoice = Invoice.find(params[:id])
  end
end
