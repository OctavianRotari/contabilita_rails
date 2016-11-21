require 'rails_helper'

describe TicketsDashboard, type: :model do
  let(:time_now) { Time.zone.now }
  let(:params) { {month: time_now.month, year: time_now.year } }
  let(:ticket) { create(:ticket) }
  let(:administrative_ticket) { create(:administrative_ticket) }
  let(:user) { create(:user) }
  let(:tickets_dashboard) { TicketsDashboard.new(user, params) }

  before :each do
    user
    create(:vehicle)
    ticket
  end

  describe '#administrative' do
    it 'returns all the administrative tickets' do
      administrative_ticket
      create(:administrative_ticket, date_of_issue: Time.zone.now - 1.month)
      expect(tickets_dashboard.administrative).to eq([administrative_ticket])
    end
  end

  describe '#vehicle' do
    it 'returns all the vehicle tickets' do
      create(:ticket, date_of_issue: Time.zone.now - 1.month)
      expect(tickets_dashboard.vehicle).to eq([ticket])
    end
  end
end
