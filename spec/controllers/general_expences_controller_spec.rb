require 'rails_helper'

describe GeneralExpencesController, type: :controller do
  sign_in_user

  before :each do
    request.env["HTTP_REFERER"] = "where_i_came_from"
  end

  describe 'displays error message ' do
    it 'if there are no vehicles that chargeable of general expences' do
      get :index
      expect(flash[:error]).to eq("Aggiungere prima un mezzo che e' imputabile per le spese generali")
      expect(response).to redirect_to("where_i_came_from")
    end
  end
end
