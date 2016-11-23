require 'rails_helper'

describe InvoicesController, type: :controller do
  sign_in_user

  let(:category) { create(:category) }
  let(:company) { create(:company) }
  let(:vehicle) { create(:vehicle) }

  before :each do
    request.env["HTTP_REFERER"] = 'where_i_came_from'
  end

  describe 'before each action' do
    it 'checks if a vehicle exists' do
      get :new
      expect(flash[:error]).to match('Aggiungere almeno un veicolo')
    end

    describe 'after a vehicle is created' do
      before :each do
        vehicle
      end

      it 'checks if a category exists' do
        get :new
        expect(flash[:error]).to match('Aggiungere almeno una categoria')
      end

      it 'checks if a company exists' do
        category
        get :new
        expect(flash[:error]).to match("Aggiungere almeno un'azienda")
      end
    end
  end


  describe 'when an invoice is valid' do
    before :each do
      request.env["HTTP_REFERER"] = "where_i_came_from"
      vehicle
      category
      company
    end

    let(:invoice_params) { attributes_for(:invoice_params_general_expenses) }
    let(:invoice_vehicle) { attributes_for(:invoice_params_vehicle)  }

    it 'calculates total vat total and total taxable' do
      post :create, invoice: invoice_params
      expect(Invoice.first.total).to eq(110)
      expect(Invoice.first.total_vat).to eq(10)
      expect(Invoice.first.total_taxable).to eq(100)
    end

    it 'saves vehicle id and at the expense of' do
      post :create, invoice: invoice_vehicle
      expect(Invoice.first.vehicle_id).to eq(1)
      expect(Invoice.first.at_the_expense_of).to eq('specific_vehicle')
    end

    it 'shows success message and redirects to invoice' do
      post :create, invoice: invoice_params
      expect(flash[:success]).to match('Fattura aggiunta')
      expect(response).to redirect_to(invoice_path(id: 1))
    end

    describe 'update' do
      it 'renders page with success when updated' do
        invoice_create = create(:invoice)
        invoice = attributes_for(:invoice)
        put :update, id: invoice_create.id, invoice: invoice
        expect(response).to redirect_to(assigns(:invoice))
        expect(flash[:success]).to match("La fattura e' stata aggiornata")
      end
    end

    describe 'when invoice is deleted' do
      it 'renders page with success and redirects to dashboard' do
        create(:invoice)
        delete :destroy, id: 1
        expect(flash[:success]).to match('Fattura elliminata')
        expect(response).to redirect_to(dashboard_invoices_path)
      end

      it 'renders page with success and redirects :back' do
        create(:invoice)
        create(:invoice)
        delete :destroy, id: 1
        expect(flash[:success]).to match('Fattura elliminata')
        expect(response).to redirect_to("where_i_came_from")
      end
    end
  end
end
