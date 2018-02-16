class InvoicesController < ApplicationController
  before_action :find_invoice, only: [:show, :update, :destroy]
  
  def index
    @invoices = Invoice.all
  end
  
  def new
    @invoice = Invoice.new
  end
  
  def create
    @invoice = Invoice.create(invoice_params)
    @invoice.save
    redirect_to @invoice
  end
  
  def update
    if @invoice.update(invoice_update_params)
      redirect_to @invoice
    else
      flash[:errors] = @invoice.errors.full_messages.to_sentance
    end
  end
  
  def show
  end
  
  def destroy
    @invoice.destroy
    redirect_to @invoice
  end
  
  def invoice_params
    params.require(:invoice).permit(:unit_price_eur, :workdays_total, :date,
                                    :invoice_template_id, :workdays, :number)
  end
  
  def invoice_update_params
    params.require(:invoice).permit(:template)
  end
  
  def find_invoice
    @invoice = Invoice.find(params[:id])
  end
end
