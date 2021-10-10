casa = PropertyType.create!(name: 'Casa')
dono = PropertyOwner.create!(email: '123@doe.com.br', password: '123456')
visitante = User.create!(email: 'everton.edesio@gmail.com', password: '123456')
Property.create!({ title: 'Casa com quintal em Copacabana', 
                  description: 'Excelente casa, recém reformada com 2 vagas de garagem',
                  rooms: 3, parking_slot: true, bathrooms: 2, daily_rate: 150,
                  property_type: casa, property_owner: dono
                })

apartamento = PropertyType.create!(name: 'Apartamento')
Property.create!({ title: 'Cobertura em Manaus', 
                  description: 'Cobertura de 300m2, churrasqueira e sauna privativa',
                  rooms: 5, parking_slot: false, bathrooms: 2, daily_rate: 150,
                  property_type: apartamento, property_owner: dono
                })

