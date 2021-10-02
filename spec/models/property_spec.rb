require 'rails_helper'

describe Property do
    context 'validations' do
        let(:property){Property.new}

        it 'title must be present' do
            #property = Property.new # nao preciso declarar pois ja foi feito com let
            #Property.new equivale a subject
            #subject.valid?
            property.valid?
            expect(property.errors.full_messages_for(:title)).to include('Título não pode ficar em branco')
            #expect(propery.errors.where(:title)).to include('não pode ficar em branco')
            #property.errors.where(:title).include?('não pode ficar em branco')        
        end

        it 'description must be present' do            
            property.valid?
            expect(property.errors.full_messages_for(:description)).to include('Descrição não pode ficar em branco')
        end           

        
        it 'rooms must be present' do
            property.valid?
            expect(property.errors.full_messages_for(:rooms)).to include('Quartos não pode ficar em branco')                              
        end
        it 'bathrooms must be present' do
            property.valid?
            expect(property.errors.full_messages_for(:bathrooms)).to include('Banheiros não pode ficar em branco')                              
        end
        it 'daily_rate title must be present' do
            property.valid?
            expect(property.errors.full_messages_for(:daily_rate)).to include('Diária não pode ficar em branco')                              
        end    

    end
end

#expect(page).to have_content('Título não pode ficar em branco')
        #expect(page).to have_content('Descrição não pode ficar em branco')
        #expect(page).to have_content('Quartos não pode ficar em branco')
        #expect(page).to have_content('Banheiro não pode ficar em branco')
        #expect(page).to have_content('Diária não pode ficar em branco')