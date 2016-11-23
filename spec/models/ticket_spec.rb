require 'rails_helper'

describe Ticket, type: :model do
  let(:ticket) { create(:ticket) }
  let(:administrative_ticket) { create(:administrative_ticket) }
  let(:user) { create(:user) }

  before :each do
    user
    create(:vehicle)
    ticket
  end

  describe '#month' do
    it 'returns current_month tickets' do
      create(:ticket, date_of_issue: Time.zone.now - 1.month)
      expect(Ticket.month).to eq([ticket])
    end
  end

  describe '#year' do
    it 'returns current_year tickets' do
      create(:ticket, date_of_issue: Time.zone.now - 1.year)
      expect(Ticket.year).to eq([ticket])
    end
  end

  describe '#administrative_current_user' do
    it 'returns only administrative tickets' do
      administrative_ticket
      ticket
      expect(Ticket.administrative_current_user(user.id)).to eq([administrative_ticket])
    end
  end

  describe '#total_vehicle_month' do
    it 'returns the total of the tickets for vehicle' do
      create(:ticket, date_of_issue: Time.zone.now - 1.month)
      expect(Ticket.total_vehicles_month).to eq(90)
    end
  end

  describe '#total_vehicle_year' do
    it 'returns the total of the tickets for vehicle' do
      create(:ticket, date_of_issue: Time.zone.now - 1.year)
      expect(Ticket.total_vehicles_year).to eq(90)
    end
  end

  describe '#total_administrative_month' do
    it 'returns the total of administrative tickets' do
      administrative_ticket
      create(:administrative_ticket, date_of_issue: Time.zone.now - 1.month)
      expect(Ticket.total_administrative_month(user.id)).to eq(90)
    end
  end

  describe '#total_administrative_year' do
    it 'returns the total of administrative tickets' do
      administrative_ticket
      create(:administrative_ticket, date_of_issue: Time.zone.now - 1.year)
      expect(Ticket.total_administrative_year(user.id)).to eq(90)
    end
  end
end
