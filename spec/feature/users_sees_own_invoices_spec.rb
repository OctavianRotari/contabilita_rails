require 'rails_helper'

feature 'user sees own invoices' do
  scenario 'all the invoices' do
    invoice = 'Bezzi 100 21 01/04/2015 de234ed 30/04/2015 Bonifico'
    Invoice.create(supplier: 'Bezzi', total:100, vat:21, date:'01/04/2015', plate:'de234ed', deadline:'30/04/2015', type_of_payment:'Bonifico')
    visit '/'
    click_link 'Fatture'
    expect(page).to have_content invoice
  end
end
