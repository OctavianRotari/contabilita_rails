require 'rails_helper'

describe TicketsController, type: :controller do
  sign_in_user
  let(:ticket) { create(:ticket) }
  let(:vehicle) { create(:vehicle)}

  before :each do
    request.env["HTTP_REFERER"] = 'where_i_came_from'
  end

  describe 'before each action' do
    it 'checks if a vehicle exists' do
      get :new
      expect(flash[:error]).to match("Aggiungere prima un mezzo che e' imputabile per le spese generali")
    end
  end

  describe 'when ticket is valid' do
    before :each do
      vehicle
    end

    it 'saves the ticket' do
      ticket_params = attributes_for(:ticket)
      post :create, ticket: ticket_params
      expect(response).to redirect_to("/tickets/vehicle_dashboard?month=#{Time.zone.now.month}&year=#{Time.zone.now.year}")
      expect(Ticket.first.total).to eq(90)
    end

    it 'saves ticket without vehicle_id' do
      ticket_params = attributes_for(:administrative_ticket)
      post :create, ticket: ticket_params
      expect(response).to redirect_to("/tickets/administrative_dashboard?month=#{Time.zone.now.month}&year=#{Time.zone.now.year}")
      expect(Ticket.first.vehicle_id).to eq(nil)
      expect(Ticket.first.type_of).to eq(2)
    end

    describe 'update' do
      it 'renders page with success when updated' do
        ticket_create = create(:ticket)
        ticket = attributes_for(:ticket)
        put :update, id: ticket_create.id, ticket: ticket
        ticket = Ticket.first
        expect(response).to redirect_to("/tickets/vehicle_dashboard?month=#{Time.zone.now.month}&year=#{Time.zone.now.year}")
        expect(flash[:success]).to match("La multa e' stata aggiornata")
      end
    end

    describe 'when ticket is deleted' do
      before(:each) do
        ticket
      end

      it 'renders page with success and redirects to dashboard' do
        delete :destroy, id: 1
        expect(flash[:success]).to match('Multa eliminata')
        expect(response).to redirect_to(dashboard_invoices_path)
      end

      it 'renders page with success and redirects :back' do
        create(:ticket)
        delete :destroy, id: 1
        expect(flash[:success]).to match('Multa eliminata')
        expect(response).to redirect_to('where_i_came_from')
      end
    end
  end
end
