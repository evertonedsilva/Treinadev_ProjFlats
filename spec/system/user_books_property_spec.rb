require 'rails_helper'

describe 'user books property' do
  it 'successfully' do
   
    apartamento = PropertyType.create!(name: 'Apartamento')
    jani = PropertyOwner.create!(email: 'jani@doe.com.br', password: '123456789')
    imovel = Property.create!(title: 'Apartamento Novo',
                                description: 'Um apartamento legal',
                                rooms: 3, bathrooms: 2, pets: true, daily_rate: 100,
                                property_type: apartamento, property_owner: jani)
    
    visitante = User.create!(email: 'cadu@bilu.com.br', password: '123456')

    login_as visitante, scope: :user
    visit root_path
    click_on imovel.title
    fill_in 'Data de início', with: '10/10/2021'
    fill_in 'Data de término', with: '12/10/2021'
    fill_in 'Quantidade de pessoas', with: '3'
    click_on 'Enviar Reserva'

    expect(page).to have_content('10/10/2021')
    expect(page).to have_content('12/10/2021')
    expect(page).to have_content(/3/)
    expect(page).to have_content('R$ 200,00')
    expect(page).to have_content('Pedido de reserva enviado com sucesso')
  end
end



 
    