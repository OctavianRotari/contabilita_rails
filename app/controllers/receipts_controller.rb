class ReceiptsController < ApplicationController
  before_action :authenticate_user!

  def new
    @receipt = Receipt.new(receipt_params_insurance_id)
    @insurance = Insurance.find(insurance_id)
  end

  def edit
    @receipt = Receipt.find(params[:id])
    @insurance = Insurance.find(insurance_id)
  end

  def update
    @receipt = Receipt.find(params[:id])
    @insurance = Insurance.find(insurance_id)
    if @receipt.update(receipt_params)
      flash[:success] = 'Ricevuta di pagamento aggiornata'
      redirect_to insurance_path(id: insurance_id)
    else
      render 'edit'
    end
  end

  def create
    @receipt = Receipt.new(receipt_params_insurance_id)
    @insurance = Insurance.find(insurance_id)
    if @receipt.save
      flash[:success] = 'Ricevuta di pagamento aggiunta'
      redirect_to insurance_path(id: insurance_id)
    else
      render 'new'
    end
  end

  private

  def receipt_params
    params.require(:receipt).permit(:paid, :policy_number, :payment_date, :method_of_payment)
  end

  def receipt_params_insurance_id
    receipt_params.merge!(insurance_id: insurance_id)
  end

  def insurance_id
    @_insurance_id ||= params[:insurance_id]
  end
end
