class PropertiesController < ApplicationController
    before_action :authenticate_property_owner!, only: [:new, :create]
    
    # não use bloquio automático (usando o except ao invés do only)
    def show
        @property = Property.find(params[:id])
        @property_reservation = PropertyReservation.new 
    end

    def new
        @property = Property.new
    end
    
    def create
        
        @property = Property.new(property_params)
        @property.property_owner=current_property_owner

        if @property.save
            redirect_to @property
        else
            #redirect_to new_property_path -> perde dados de preenchimento parciais
            #alternativa: flash.now[:alert] = 'Não foi possivel cadastrar o imóvel'
            render :new # nao perde os dados
        end

        #prop = Property.create(title: params[:property][:title], description: params[:property][:description], 
        #               rooms: params[:property][:rooms], bathrooms: params[:property][:bathrooms],
        #               daily_rate: params[:property][:daily_rate], pets: params[:property][:pets],
        #               parking_slot: params[:property][:parking_slot])
    
    end

    def my_properties
        @properties = current_property_owner.properties
        
    end

    private     #tudo abaixo daqui é privado
                #só os metodos/actions desse controller pode usar os métodos
                #metodos deixam de ser actions a partir daqui                

    def property_params
        params.require(:property).permit(
            :title, :description, :rooms, :bathrooms, :pets, 
            :parking_slot, :daily_rate, :property_type_id)
        
    end
        
end