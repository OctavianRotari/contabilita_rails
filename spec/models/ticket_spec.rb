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

  describe '#administrative' do
    it 'returns only administrative tickets' do
      administrative_ticket
      ticket
      expect(Ticket.administrative(user.id)).to eq([administrative_ticket])
    end
  end
end
