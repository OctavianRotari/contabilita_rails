require 'rails_helper'

feature 'user clicks on the invoice' do 
  scenario 'user sees all the invoices of that particular supplier' do
    invoice = '100 21 01/04/2015 de234ed 30/04/2015 Bonifico 100 21 15/03/2015 HE234DE 30/03/2015 Cassa'
    Invoice.create(supplier: 'Bezzi', total:100, vat:21, date:'01/04/2015', plate:'de234ed', deadline:'30/04/2015', type_of_payment:'Bonifico')
    Invoice.create(supplier: 'Bezzi', total:100, vat:21, date:'15/03/2015', plate:'HE234DE', deadline:'30/03/2015', type_of_payment:'Cassa')
    visit '/'
    click_link 'Fatture'
    first(:link, 'Bezzi').click
    expect(page).to have_content invoice
  end
end
