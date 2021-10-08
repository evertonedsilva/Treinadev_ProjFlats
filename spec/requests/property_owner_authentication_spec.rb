require 'rails_helper'

describe 'Property Owner autentication' do
    it 'cannot create poperty without login' do
        post '/properties'
        expect(response).to redirect_to(new_property_owner_session_path)
    end
    it 'cannot open new property form unless authenticated' do
        #get '/properties/new' -> integração externa com
        # outra aplicação, ex.: site de vendas faz um POST no site de entrega)
        get new_property_path
    
        expect(response).to redirect_to(new_property_owner_session_path)
      end
end
