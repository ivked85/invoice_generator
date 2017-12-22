class InvoiceTemplatesController < ApplicationController
  before_action :find_invoice_template, only: [:show, :update]
  
  def index
    @invoice_templates = InvoiceTemplate.all
  end
  
  def new
    @invoice_template = InvoiceTemplate.new
  end
  
  def create
    @invoice_template = InvoiceTemplate.create(invoice_template_attributes)
    @invoice_template.save
    redirect_to @invoice_template
  end
  
  def show
  end
  
  def update
    @invoice_template.update(invoice_template_attributes)
    redirect_to @invoice_template
  end
  
  def invoice_template_attributes
    params.require(:invoice_template).permit(:template, :name)
  end
  
  private
  
  def find_invoice_template
    @invoice_template = InvoiceTemplate.find(params[:id].to_i)
  end
end
