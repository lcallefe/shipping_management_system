require 'rails_helper'

describe 'Usuário busca por um veículo' do 
  it 'a partir da tela inicial' do 

    user = User.create!(name: 'Maria', email: 'maria@sistemadefrete.com.br', password: '12345678')

    sm = ShippingMethod.create!(flat_fee:50, name:'Delivery', min_distance:5, max_distance:20, min_weight:5, max_weight:50, 
                                min_price:5, max_price:50, min_delivery_time:1, max_delivery_time:240)
                                
    vehicle = Vehicle.create!(brand_name:'Ford', model:'Fiesta', fabrication_year:'2001', full_capacity:100, license_plate:'ABC-1234', 
                              shipping_method_id: sm.id, status:1)

    login_as(user)
    visit root_path
    click_on 'Busca por veículo'
    fill_in 'Buscar veículo', with: 'ABC'
    click_on 'Buscar'
    
    expect(page).to have_content 'Ford - Fiesta'
    expect(page).to have_content 'Ativo'
    expect(page).to have_link('Ver detalhes', href:vehicle_path(vehicle.id))
  end

  it 'e são retornados mais de um veículo' do 

    user = User.create!(name: 'Maria', email: 'maria@sistemadefrete.com.br', password: '12345678')  
    
    sm = ShippingMethod.create!(flat_fee:45, name:'Delivery', min_distance:5, max_distance:20, min_weight:5, max_weight:50, 
                                min_price:5, max_price:50, min_delivery_time:1, max_delivery_time:240)

    Vehicle.create!(brand_name:'Ford', model:'Fiesta', fabrication_year:'2001', full_capacity:100, license_plate:'ABC-1234', 
                    shipping_method_id: sm.id, status:1)

    Vehicle.create!(brand_name:'Volkswagen', model:'Golf', fabrication_year:'2005', full_capacity:100, license_plate:'ABC-1238', 
                    shipping_method_id: sm.id, status:1)

    login_as(user)
    visit root_path
    click_on 'Busca por veículo'
    fill_in 'Buscar veículo', with: 'ABC'
    click_on 'Buscar'
    
    expect(page).to have_content 'Ford - Fiesta'
    expect(page).to have_content 'Ativo'
    expect(page).to have_content 'Volkswagen - Golf'
    expect(page).to have_link('Voltar', href:vehicles_path)
  end
  it 'e pesquisa por status' do 

    user = User.create!(name: 'Maria', email: 'maria@sistemadefrete.com.br', password: '12345678')  
    sm = ShippingMethod.create!(flat_fee:45, name:'Delivery', min_distance:5, max_distance:20, min_weight:5, max_weight:50, 
                                min_price:5, max_price:50, min_delivery_time:1, max_delivery_time:240)
    Vehicle.create!(brand_name:'Ford', model:'Fiesta', fabrication_year:'2001', full_capacity:100, license_plate:'EFJ-1234', 
                    shipping_method_id: sm.id, status:1)
    Vehicle.create!(brand_name:'Volkswagen', model:'Golf', fabrication_year:'2005', full_capacity:100, license_plate:'ABC-1234', 
                    shipping_method_id: sm.id, status:2)

    login_as(user)
    visit root_path
    click_on 'Busca por veículo'
    fill_in 'Buscar veículo', with: ''
    select "Em entrega", :from => "status"
    click_on 'Buscar'
    
    expect(page).not_to have_content 'Ford - Fiesta'
    expect(page).to have_content 'Volkswagen - Golf'
    expect(page).to have_content 'Em entrega'
  end
  
  it 'e pesquisa pela placa' do 

    user = User.create!(name: 'Maria', email: 'maria@sistemadefrete.com.br', password: '12345678')  

    sm = ShippingMethod.create!(flat_fee:45, name:'Delivery', min_distance:5, max_distance:20, min_weight:5, max_weight:50, 
                                min_price:5, max_price:50, min_delivery_time:1, max_delivery_time:240)
    
    Vehicle.create!(brand_name:'Ford', model:'Mustang', fabrication_year:'2020', full_capacity:100, license_plate:'ABC-1234', 
                    shipping_method_id: sm.id, status:2)
    Vehicle.create!(brand_name:'Volkswagen', model:'Golf', fabrication_year:'2005', full_capacity:100, license_plate:'EFJ-1234', 
                    shipping_method_id: sm.id, status:0)

    login_as(user)
    visit root_path
    click_on 'Busca por veículo'
    fill_in 'Buscar veículo', with: 'EFJ'
    select "Em Manutenção", from: "status"
    click_on 'Buscar'
  
    expect(page).to have_content 'Volkswagen - Golf'
    expect(page).to have_content 'Em Manutenção'
    expect(page).not_to have_content 'Ford - Mustang'
  end
end