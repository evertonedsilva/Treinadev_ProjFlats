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
