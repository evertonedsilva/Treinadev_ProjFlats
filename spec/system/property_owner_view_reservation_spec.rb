require 'rails_helper'

describe 'Property owner view reservations' do
  it 'should view reservations from owned properties' do
    property_type = PropertyType.create!(name: 'Um tipo qualquer')
    john = PropertyOwner.create!(email: 'john@doe.com.br', password: '123456')
    johns_property = Property.create!(title: 'Apartamento Novo',
                                description: 'Um apartamento legal',
                                rooms: 3, bathrooms: 2, pets: true, daily_rate: 100,
                                property_type: property_type, property_owner: john)

    andrew = User.create!(email: 'andrew@doe.com.br', password: '123456')

    PropertyReservation.create!(start_date: '2021-10-19', end_date: '2021-10-22',
                               guests: 6, property: johns_property, user: andrew)


    login_as john, scope: :property_owner
    visit root_path
    click_on 'Meus Imóveis'
    click_on 'Apartamento Novo'

    expect(page).not_to have_content 'Reserve Agora'
    expect(page).to have_content 'Reservas'
    expect(page).to have_content 'Reserva de andrew@doe.com.br'
    expect(page).to have_content 'Data de Início: 19/10/2021'
    expect(page).to have_content 'Data de Saída: 22/10/2021'
    expect(page).to have_content 'Total de Pessoas: 6'
    expect(page).to have_content 'Status: Pendente'
  end

  it 'and does not view other properties reservation' do
    property_type = PropertyType.create!(name: 'Um tipo qualquer')
    john = PropertyOwner.create!(email: 'john@doe.com.br', password: '123456')
    johns_property = Property.create!(title: 'Apartamento Novo',
                                description: 'Um apartamento legal',
                                rooms: 3, bathrooms: 2, pets: true, daily_rate: 100,
                                property_type: property_type, property_owner: john)


    jane = PropertyOwner.create!(email: 'jane@doe.com.br', password: '123456')
    janes_property = Property.create!(title: 'Apartamento Vintage',
                                description: 'Um apartamento com muito estilo',
                                rooms: 3, bathrooms: 1, pets: true, daily_rate: 150,
                                property_type: property_type, property_owner: jane)

    andrew = User.create!(email: 'andrew@doe.com.br', password: '123456')

    PropertyReservation.create!(start_date: '2021-10-23', end_date: '2021-10-26',
                              guests: 6, property: janes_property, user: andrew)


    login_as john, scope: :property_owner
    visit root_path
    click_on 'Apartamento Vintage'

    expect(page).not_to have_content("Reserve Agora")
    expect(page).not_to have_content('Reserva de andrew@doe.com.br')
    expect(page).not_to have_content('Data de Início: 23/10/2021')
    expect(page).not_to have_content('Data de Saída: 26/10/2021')
  end

  it 'and accept reservation' do
    property_type = PropertyType.create!(name: 'Um tipo qualquer')
    john = PropertyOwner.create!(email: 'john@doe.com.br', password: '123456')
    johns_property = Property.create!(title: 'Apartamento Novo',
                                description: 'Um apartamento legal',
                                rooms: 3, bathrooms: 2, pets: true, daily_rate: 100,
                                property_type: property_type, property_owner: john)

    andrew = User.create!(email: 'andrew@doe.com.br', password: '123456')

    PropertyReservation.create!(start_date: '2021-10-19', end_date: '2021-10-22',
                               guests: 6, property: johns_property, user: andrew)


    login_as john, scope: :property_owner
    visit root_path
    click_on 'Meus Imóveis'
    click_on 'Apartamento Novo'
    click_on 'Aceitar Reserva'

    expect(current_path).to eq property_path(johns_property)
    expect(page).to have_content 'Reservas'
    expect(page).to have_content 'Reserva de andrew@doe.com.br'
    expect(page).to have_content 'Data de Início: 19/10/2021'
    expect(page).to have_content 'Data de Saída: 22/10/2021'
    expect(page).to have_content 'Total de Pessoas: 6'
    expect(page).to have_content 'Status: Aceita'

  end
end