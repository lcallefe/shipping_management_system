# require 'rails_helper'

# describe 'Usuário busca por um veículo' do 
#   it 'a partir da tela inicial' do 
#     # Arrange
#     user = User.create!(name: 'Maria', email: 'maria@sistemadefrete.com.br', password: '12345678')  
#     sm = Sedex.create!(name:'Sedex', flat_fee: 50)
#     sedex_dez_vehicle = Vehicle.create!(brand_name:'Ford', model:'Fiesta', fabrication_year:'2001', full_capacity:100, license_plate:'ABC-1234', 
#                                   sedex_dez_id: sm.id, status:1)
#     sedex_vehicle = Vehicle.create!(brand_name:'Chevrolet', model:'Kaddet', fabrication_year:'2001', full_capacity:100, license_plate:'ABC-1234', 
#                                   sedex_dez_id: sm.id, status:2)
#     # Act
#     login_as(user)
#     visit root_path
#     click_on 'Busca por veículo'
#     fill_in 'Buscar veículo', with: 'ABC'
    
#     # Assert
#     expect(page).to have_content 'Ford - Fiesta'
#     expect(page).to have_content 'Ativo'
#     expect(page).to have_link('Ver detalhes', href:vehicle_path(sedex_dez_vehicle.id))
#     expect(page).not_to have_content 'Chevrolet - Kadett'
#     expect(page).not_to have_content 'Em Entrega'
#   end
# end