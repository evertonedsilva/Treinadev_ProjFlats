require 'rails_helper'

describe 'Visitor visit homepage' do
   it 'and view properties' do
    #Arrange => Preparar (os dados)
    jani = PropertyOwner.create!(email: 'jani@doe.com.br', password: '123456789')
    tipo = PropertyType.create!(name: 'Casa')
    Property.create!({ title: 'Casa com quintal em Copacabana', 
                      description: 'Excelente casa, recém reformada com 2 vagas de garagem',
                      rooms: 3, parking_slot: true, bathrooms: 2, daily_rate: 150,
                      property_type: tipo, property_owner: jani
                    })

    Property.create!({ title: 'Cobertura em Manaus', 
                      description: 'Cobertura de 300m2, churrasqueira e sauna privativa',
                      rooms: 5, parking_slot: false, bathrooms: 2, daily_rate: 150,
                      property_type: tipo, property_owner: jani
                    })

    #Act => Agir (executar a funcionalidade)
    visit root_path

    #Assert => Garantir (que algo aconteceu ou NAO aconteceu)
    # 2 imoveis -> casa em copacabana; apartamento em manaus
    expect(page).to have_content("Casa com quintal em Copacabana")
    expect(page).to have_content("Excelente casa, recém reformada com 2 vagas de garagem")
    expect(page).to have_content("Quartos: 3")
    expect(page).to have_content("Cobertura em Manaus")
    expect(page).to have_content("Cobertura de 300m2, churrasqueira e sauna privativa")
    expect(page).to have_content("Quartos: 5")
  end
  it 'and theres no property available' do
    #Act => Agir (executar a funcionalidade)
    visit root_path
    expect(page).to have_content("Nenhum imóvel disponível")
  end

  it 'and view property details' do
    #Arrange => Preparar (os dados)
    property_owner = PropertyOwner.create!(email: 'jani@doe.com.br', password: '123456789')
    property_type = PropertyType.create!(name: 'Casa')
    property = Property.create!({ title: 'Casa com quintal em Copacabana', 
                      description: 'Excelente casa, recém reformada com 2 vagas de garagem',
                      rooms: 3, parking_slot: true, bathrooms: 2, pets: true, daily_rate: 500,
                      property_type: property_type, property_owner: property_owner
                    })

    Property.create!({ title: 'Cobertura em Manaus', 
                    description: 'Cobertura de 300m2, churrasqueira e sauna privativa',
                    rooms: 5, parking_slot: false, bathrooms: 3, pets: false, daily_rate: 400,
                    property_type: property_type, property_owner: property_owner
                  })

    #Act => Agir (executar a funcionalidade)
    visit root_path
    click_on 'Casa com quintal em Copacabana'

    #Assert => Garantir (que algo aconteceu ou NAO aconteceu)
    expect(page).not_to have_content('Cobertura de 300m2, churrasqueira e sauna privativa')
    expect(page).to have_content("Casa com quintal em Copacabana")
    expect(page).to have_content("Excelente casa, recém reformada com 2 vagas de garagem")
    expect(page).to have_content("Quartos: 3")
    expect(page).to have_content("Banheiros: 2")
    expect(page).to have_content("Aceita Pets: Sim")
    expect(page).to have_content("Estacionamento: Sim")
    expect(page).to have_content("Diária: R$ 500,00")
    expect(page).to have_content("Tipo: Casa")
    expect(page).to have_content("Imóvel de:jani@doe.com.br")
                                 
  end



end