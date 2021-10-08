require 'rails_helper'

describe 'Property owner view own properties' do
    it 'using menu' do
        #arrange
        property_owner = PropertyOwner
        .create!(email: 'jani@doe.com.br', password: '123456789')

        #act
        login_as property_owner, scope: :property_owner
        visit root_path

        #assert
        expect(page).to have_link('Meus Imóveis', href: my_properties_properties_path)
        #rota customizada my_properties adicionada em properties (routes)
    end

    it 'and should view owned properties' do
        jani = PropertyOwner.create!(email: 'jani@doe.com.br', password: '123456789')
        peter = PropertyOwner.create!(email: 'peter@parker.com.br', password: '123456789')


        casa = PropertyType.create(name: 'Casa')
        Property.create!({ title: 'Casa com quintal em Copacabana', 
            description: 'Excelente casa, recém reformada com 2 vagas de garagem',
            rooms: 3, parking_slot: true, bathrooms: 2, daily_rate: 150,
            property_type: casa, property_owner: jani
        })
        Property.create!({ title: 'Casa com piscina em Porto Alegre', 
            description: 'Ótima casa, com vista para o Guaíba',
            rooms: 2, parking_slot: true, bathrooms: 1, daily_rate: 100,
            property_type: casa, property_owner: peter
        })
        
        login_as jani, scope: :property_owner
        visit root_path
        click_on 'Meus Imóveis'
       

        expect(page).to have_content 'Casa com quintal em Copacabana'
        expect(page).to_not have_content 'Casa com piscina em Porto Alegre'
    end
end