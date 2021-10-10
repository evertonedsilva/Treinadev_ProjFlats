require 'rails_helper'

describe 'Visitor filter properties by type' do
    it 'show view links on nav bar' do
        #Arrange
        PropertyType.create!(name: 'Apartamento')
        PropertyType.create!(name: 'Casa')
        PropertyType.create!(name: 'Sítio')

        #Act
        visit root_path

        #Assert
        expect(page).to have_link('Apartamento')
        expect(page).to have_link('Casa')    
        expect(page).to have_link('Sítio')    
    
    end
    it 'sucessfully' do
    #arrange
    jani = PropertyOwner.create!(email: 'jani@doe.com.br', password: '123456789')
    casa = PropertyType.create!(name: 'Casa')
    Property.create!({ title: 'Casa com quintal em Copacabana', 
                  description: 'Excelente casa, recém reformada com 2 vagas de garagem',
                  rooms: 3, parking_slot: true, bathrooms: 2, daily_rate: 150,
                  property_type: casa, property_owner: jani
                })

    apartamento = PropertyType.create!(name: 'Apartamento')
    Property.create!({ title: 'Cobertura em Manaus', 
                  description: 'Cobertura de 300m2, churrasqueira e sauna privativa',
                  rooms: 5, parking_slot: false, bathrooms: 2, daily_rate: 150,
                  property_type: apartamento, property_owner: jani
                })


    #act
        visit root_path
        click_on 'Casa'

    #assert
    expect(page).to have_css('h1', text: 'Imóveis do tipo Casa')
    expect(page).to have_content('Casa com quintal em Copacabana')
    expect(page).not_to have_link('Cobertura em Manaus')
    end

end