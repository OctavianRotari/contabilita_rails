require 'rails_helper'

feature 'user clicks on the invoice' do 
  scenario 'user sees all the invoices of that particular supplier' do
    supplier = ClientsAndSupplier.create(name:'Bezzi',adress:'Ravenna',number:'345')
    supplier.invoices.create(total:100, vat:21, date:'01/04/2015', plate:'de234ed', deadline:'30/04/2015', type_of_payment:'Bonifico')
    supplier.invoices.create(total:100, vat:21, date:'15/03/2015', plate:'HE234DE', deadline:'30/03/2015', type_of_payment:'Cassa')
    visit '/'
    click_link 'Fatture'
    first(:link, 'Bezzi').click
    expect(page).to have_css 'td', text: 'Bonifico'
    expect(page).to have_css 'td', text: 'Cassa'
  end
end
