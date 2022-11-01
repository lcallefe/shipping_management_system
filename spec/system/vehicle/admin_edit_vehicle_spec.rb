require 'rails_helper'

describe 'Usuáro altera status da modalidade de entrega' do
  it 'a partir da tela inicial' do
    user = User.create!(name: 'Maria', email: 'maria@sistemadefrete.com.br', password: '12345678', admin:true)  
    
    sm = ShippingMethod.create!(flat_fee:45, name:'Sedex', min_distance:5, max_distance:20, min_weight:5, max_weight:50, 
                                min_price:5, max_price:50, min_delivery_time:1, max_delivery_time:240)

    Vehicle.create!(brand_name:'Ford', model:'Fiesta', fabrication_year:'2001', full_capacity:100, license_plate:'EFJ-1234', 
                    shipping_method_id: sm.id, status:1)
  
    login_as(user)
    visit root_path 
    click_on 'Busca por veículo'
    fill_in 'Buscar veículo', with: 'EFJ'
    click_on 'Buscar'
    click_on 'Ver detalhes'
    click_on 'Alterar status'
    select 'Em Manutenção', from: 'Status'
    click_on 'Salvar'

    expect(page).to have_content('Ford - Fiesta')
    expect(page).to have_content('Status:')
    expect(page).to have_content('Em Manutenção')
    expect(current_path).to eq vehicles_path
  end

  it 'e volta para a tela de detalhes do veículo' do
    user = User.create!(name: 'João', email: 'joão@sistemadefrete.com.br', password: '12345678', admin:true)  
    
    sm = ShippingMethod.create!(flat_fee:45, name:'Delivery', min_distance:5, max_distance:20, min_weight:5, max_weight:50, 
                                min_price:5, max_price:50, min_delivery_time:1, max_delivery_time:240)
    
    vehicle = Vehicle.create!(brand_name:'Renault', model:'Sedan', fabrication_year:'2001', full_capacity:100, license_plate:'EFJ-1234', 
                              shipping_method_id: sm.id, status:1)

    login_as(user)
    visit root_path 
    click_on 'Busca por veículo' 
    fill_in 'Buscar veículo', with: 'EFJ'
    click_on 'Buscar'
    click_on 'Ver detalhes'
    click_on 'Alterar status'
    click_on 'Voltar'
         
    expect(page).to have_content('Renault - Sedan')
    expect(page).to have_content('Status:')
    expect(page).to have_content('Ativo')
    expect(page).not_to have_button('Salvar')
    expect(current_path).to eq vehicle_path(vehicle.id)
  end 
end