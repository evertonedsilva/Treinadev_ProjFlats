require 'rails_helper'

describe 'Visitor register property' do
    it 'sucessfully' do
        #arrange
        PropertyType.create!(name: 'Casa')
        property_owner = PropertyOwner
        .create!(email: 'jane@doe.com.br', password: '123456789') #adicionado na aula de Login

        

        #act
        login_as property_owner, scope: :property_owner
        visit root_path
        click_on "Cadastrar Imóvel"
        
        fill_in 'Título', with: 'Casa em Florianópolis'
        fill_in 'Descrição', with: 'Ótima casa perto da UFSC'
        fill_in 'Quartos', with: 3
        fill_in 'Banheiros', with: '2'
        fill_in 'Diária', with: 200
        select 'Casa', from: 'Tipo'
        check 'Aceita Pets'
        check 'Estacionamento'
        click_on 'Enviar'

        #assert
        expect(page).to have_content('Casa em Florianópolis')
        expect(page).to have_content('Ótima casa perto da UFSC')
        expect(page).to have_content("Quartos: 3")
        expect(page).to have_content("Banheiros: 2")
        expect(page).to have_content("Aceita Pets: Sim")
        expect(page).to have_content("Estacionamento: Sim")
        expect(page).to have_content("Diária: R$ 200,00")
        expect(page).to have_content("Tipo: Casa")
    end
    
    it 'and must fill all fields' do
        #Teste de erro de preenchimento:

        #arrange
        PropertyType.create!(name: 'Casa')
        property_owner = PropertyOwner
        .create!(email: 'jane@doe.com.br', password: '123456789') #adicionado na aula de Login

        #act
        login_as property_owner, scope: :property_owner
        visit root_path
        click_on "Cadastrar Imóvel"
        
        
        #fill_in 'Título', with: 'Casa em Florianópolis'
        #fill_in 'Descrição', with: 'Ótima casa perto da UFSC'
        #fill_in 'Quartos', with: 3
        #fill_in 'Banheiros', with: '2'
        #fill_in 'Diária', with: 200
        #check 'Aceita Pets'
        #check 'Estacionamento'
        click_on 'Enviar'

        expect(page).to have_content('Título não pode ficar em branco')
        expect(page).to have_content('Descrição não pode ficar em branco')
        expect(page).to have_content('Quartos não pode ficar em branco')
        expect(page).to have_content('Banheiros não pode ficar em branco')
        expect(page).to have_content('Diária não pode ficar em branco')
        #expect(page).to have_content('não pode ficar em branco',count: 5)
        expect(Property.count).to eq(0)

        # TODO verificar que o daily_rate e bathrooms são numeros
        # TODO verificar que o daily_rate e bathrooms são maiores que zero
        # DICA: > rails notes # retorna de todos os códigos onde esta escrito TODO
    end 


end

