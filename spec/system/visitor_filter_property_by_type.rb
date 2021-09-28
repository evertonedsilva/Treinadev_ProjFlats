require 'rails_helper'

describe 'Visitorfilter properties by type' do
    it 'show view links on nav bar' do
        #Arrange
        PropertyType.create!(name: 'Apartamento')
        PropertyType.create!(name: 'Casa')
        PropertyType.create!(name: 'Sítio')

        #Act
        visit root_path

        #Assert
    end
describe 'sucessfully' do
    #arrange
    apartamento = Property.create!('Casa')
end