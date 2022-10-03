require 'rails_helper'

describe 'Usuáro vê pedidos' do
  it 'a partir da tela principal' do
    # Arrange 
    user = User.create!(name: 'Sergio', email: 'sergio@sistemadefrete.com.br', password: '12345678', admin:false)
    vehicle = Vehicle.create!(license_plate: 'BMP-1586', name:'Carro', brand_name: 'Fiesta', model: 'Ford', fabrication_year: '1999',
                              full_capacity:'50')
    second_vehicle = Vehicle.create!(license_plate: 'BMP-1486', name:'Caminhão', brand_name: 'Volvo', model: 'Volvo', fabrication_year: '2005',
                                     full_capacity:'1000', status:0)
    ShippingMethod.create!(name: 'Sedex', min_distance:10, max_distance:20, min_height:10, max_height: 20, flat_fee: 50, weight_fee:35, distance_fee:45, vehicle_id:vehicle.id)
    ShippingMethod.create!(name: 'Sedex 10', min_distance:10, max_distance:20, min_height:10, max_height: 20, flat_fee: 50, weight_fee:35, distance_fee:45, vehicle_id:second_vehicle.id, status:0)

    # Act
    login_as(user)
    visit root_path
    click_on 'Modalidades de transporte'

    # Assert
    expect(page).to have_content('Modalidades de transporte')
    expect(page).to have_content('Sedex')
    expect(page).to have_content('Sedex 10')
    expect(page).to have_content('Status')
    expect(page).to have_content('Ativo')
    expect(page).to have_content('Inativo')
    expect(page).not_to have_link('Cadastrar modalidade de transporte')
    expect(current_path).to eq(shipping_methods_path)
  end
  it 'e volta para a tela inicial' do
    # Arrange 
    user = User.create!(name: 'Sergio', email: 'sergio@sistemadefrete.com.br', password: '12345678', admin:false)
    vehicle = Vehicle.create!(license_plate: 'BMP-1586', name:'Carro', brand_name: 'Fiesta', model: 'Ford', fabrication_year: '1999',
                              full_capacity:'50')
    ShippingMethod.create!(name: 'Sedex', min_distance:10, max_distance:20, min_height:10, max_height: 20, flat_fee: 50, weight_fee:35, distance_fee:45, vehicle_id:vehicle.id)

    # Act
    login_as(user)
    visit root_path
    click_on 'Modalidades de transporte'
    click_on 'Voltar'

    # Assert
    expect(page).not_to have_content('Status')
    expect(page).to have_content('Selecione a opção desejada:')
    expect(current_path).to eq(root_path)
  end
  it 'e não há modalidades de transporte cadastradas' do
    # Arrange 
    user = User.create!(name: 'Sergio', email: 'sergio@sistemadefrete.com.br', password: '12345678', admin:false)

    # Act
    login_as(user)
    visit root_path
    click_on 'Modalidades de transporte'
 
    # Assert
    expect(page).not_to have_content("Veículo")
    expect(page).not_to have_content("Status")
    expect(page).to have_content("Não há modalidades de transporte cadastradas")
    expect(current_path).to eq(shipping_methods_path)
  end
end