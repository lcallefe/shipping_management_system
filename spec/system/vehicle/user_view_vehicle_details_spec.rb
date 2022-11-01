require 'rails_helper'

describe 'Usuário vê detalhes de veículo' do
  it 'a partir da tela de consulta de veículos' do
    
    user = User.create!(name: 'Maria', email: 'maria@sistemadefrete.com.br', password: '12345678', admin:true)
    sm = ShippingMethod.create!(flat_fee:45, name:'Delivery', min_distance:5, max_distance:20, min_weight:5, max_weight:50, 
                                min_price:5, max_price:50, min_delivery_time:1, max_delivery_time:240)
    vehicle = Vehicle.create!(brand_name:'Renault', model:'Sedan', fabrication_year:'2001', full_capacity:100, license_plate:'EFJ-1234', 
                              shipping_method_id: sm.id, status:1)
                                   
    login_as(user)
    visit vehicles_path
    click_on 'Ver detalhes'
 
    expect(page).to have_content 'Detalhes do veículo:'
    expect(page).to have_content 'Placa:'
    expect(page).to have_content 'EFJ-1234'
    expect(page).to have_content 'Ano de fabricação:'
    expect(page).to have_content '2001'
    expect(page).to have_content  "Capacidade do veículo:"
    expect(page).to have_content '100 kg'
    expect(page).to have_content 'Status:'
    expect(page).to have_content 'Ativo'
    expect(page).to have_content 'Método de entrega'
    expect(page).to have_content 'Delivery'
    expect(page).to have_link('Sair', href: destroy_user_session_path)
    expect(current_path).to eq vehicle_path(vehicle.id)
  end

  it 'e volta para a tela inicial' do
    user = User.create!(name: 'Maria', email: 'maria@sistemadefrete.com.br', password: '12345678', admin:true)
    sm = ShippingMethod.create!(flat_fee:45, name:'Sedex', min_distance:5, max_distance:20, min_weight:5, max_weight:50, 
                                min_price:5, max_price:50, min_delivery_time:1, max_delivery_time:240)
    vehicle = Vehicle.create!(brand_name:'Volvo', model:'FGHJ', fabrication_year:'2001', full_capacity:100, license_plate:'EFJ-1234', 
                              shipping_method_id: sm.id, status:1)
    
    login_as(user)
    visit root_path
    click_on 'Busca por veículo'
    fill_in 'Buscar veículo', with: 'EFJ'
    click_on 'Buscar'
    click_on 'Ver detalhes'
    click_on 'Voltar'
    click_on 'Voltar'
    click_on 'Voltar'
 
    expect(page).not_to have_content 'Salvar'
    expect(page).not_to have_content 'Volvo'
    expect(current_path).to eq root_path
  end
end