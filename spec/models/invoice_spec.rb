require 'spec_helper'

describe Invoice, type: :unit do
  before :each do
    create_category_of_company
    @params = { year_param: "2015"}
    company = company('Octav')
    @passive_invoice = create_passive_record(company)
    @active_invoice = create_active_record(company)
  end

  describe '#company_name' do
    it 'should return the name of the company' do
      expect(Invoice.first.company_name).to eq('Octav')
    end
  end

  describe '#payments' do
    it 'should return all the payments' do
      payments = add_payment_to_invoice(@passive_invoice)
      expect(Invoice.first.payments).to eq([payments])
    end
  end

  describe '# self active_ord_by_year' do
    it 'should not return passive invoices ' do
      expect(Invoice.active_ord_by_year(@params)).not_to eq([@passive_invoice])
    end

    it 'should return active invoices ' do
      expect(Invoice.active_ord_by_year(@params)).to eq([@active_invoice])
    end
  end

  describe '# self passive_ord_by_year' do
    it 'should not return passive invoices ' do
      expect(Invoice.passive_ord_by_year(@params)).not_to eq([@active_invoice])
    end

    it 'should return active invoices ' do
      expect(Invoice.passive_ord_by_year(@params)).to eq([@passive_invoice])
    end
  end

  describe 'invoice should not be created if fields are empty' do
    it 'should have many invoices' do
      invoice = Invoice.new(date_of_issue: "",
                            deadline: "",
                            company_id: "",
                            reason: "",
                            vehicle_id: "",
                            type_of_invoice: "")
      invoice.save
      errors_should_apear = { :date_of_issue=>["Selezionare data di emissione"],
                              :deadline=>["Selezionare data di scadenza"],
                              :company_id=>["Selezionare azienda la quale ha emesso o ricevuto la fattura"],
                              :reason=>["Selezionare il motivo della fattura"],
                              :vehicle_id=>["Selezionare il veicolo a su cui e stata registrata la fattura"],
                              :type_of_invoice=>["Selezionare il tipo di fattura"]}
      expect(invoice.errors.messages).to eq(errors_should_apear)
    end
  end

end
