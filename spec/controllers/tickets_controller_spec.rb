require 'rails_helper'

describe TicketsController, type: :controller do
  sign_in_user
  let(:ticket) { create(:ticket) }

  before :each do
    request.env["HTTP_REFERER"] = 'where_i_came_from'
  end

  describe 'before each action' do
    it 'checks if a vehicle exists' do
      get :new
      expect(flash[:error]).to match('Aggiungere almeno un veicolo')
    end
  end

  describe 'after a vehicle is created' do
    before :each do
      create(:vehicle)
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
  end
end
