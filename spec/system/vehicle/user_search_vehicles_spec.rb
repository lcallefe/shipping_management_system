require 'rails_helper'

describe 'Usuário busca por um veículo' do 
  it 'a partir da tela inicial' do 
    # Arrange
    user = User.create!(name: 'Maria', email: 'maria@sistemadefrete.com.br', password: '12345678')  
    sm = Sedex.create!(name:'Sedex', flat_fee: 50)
    Vehicle.delete_all
    vehicle = Vehicle.create!(brand_name:'Ford', model:'Fiesta', fabrication_year:'2001', full_capacity:100, license_plate:'ABC-1234', 
                              sedex_dez_id: sm.id, status:1)

    # Act
    login_as(user)
    visit root_path
    click_on 'Busca por veículo'
    fill_in 'Buscar veículo', with: 'ABC'
    click_on 'Buscar'
    
    # Assert
    expect(page).to have_content 'Ford - Fiesta'
    expect(page).to have_content 'Ativo'
    expect(page).to have_link('Ver detalhes', href:vehicle_path(vehicle.id))
  end
  it 'e são retornados mais de um veículo' do 
    # Arrange
    user = User.create!(name: 'Maria', email: 'maria@sistemadefrete.com.br', password: '12345678')  
    sm = Sedex.create!(name:'Sedex', flat_fee: 50)
    Vehicle.delete_all
    Vehicle.create!(brand_name:'Ford', model:'Fiesta', fabrication_year:'2001', full_capacity:100, license_plate:'ABC-1234', 
                    sedex_dez_id: sm.id, status:1)
    Vehicle.create!(brand_name:'Volkswagen', model:'Golf', fabrication_year:'2005', full_capacity:100, license_plate:'ABC-1238', 
                    sedex_dez_id: sm.id, status:1)

    # Act
    login_as(user)
    visit root_path
    click_on 'Busca por veículo'
    fill_in 'Buscar veículo', with: 'ABC'
    click_on 'Buscar'
    
    # Assert
    expect(page).to have_content 'Ford - Fiesta'
    expect(page).to have_content 'Ativo'
    expect(page).to have_content 'Volkswagen - Golf'
    expect(page).to have_link('Voltar', href:vehicles_path)
  end
  it 'e pesquisa por status' do 
    # Arrange
    user = User.create!(name: 'Maria', email: 'maria@sistemadefrete.com.br', password: '12345678')  
    sm = Sedex.create!(name:'Sedex', flat_fee: 50)
    Vehicle.delete_all
    Vehicle.create!(brand_name:'Ford', model:'Fiesta', fabrication_year:'2001', full_capacity:100, license_plate:'EFJ-1234', 
                    sedex_dez_id: sm.id, status:1)
    Vehicle.create!(brand_name:'Volkswagen', model:'Golf', fabrication_year:'2005', full_capacity:100, license_plate:'ABC-1234', 
                    sedex_dez_id: sm.id, status:2)

    # Act
    login_as(user)
    visit root_path
    click_on 'Busca por veículo'
    fill_in 'Buscar veículo', with: ''
    select "Em entrega", :from => "status"
    click_on 'Buscar'
    
    # Assert
    expect(page).not_to have_content 'Ford - Fiesta'
    expect(page).to have_content 'Volkswagen - Golf'
    expect(page).to have_content 'Em entrega'
  end
  it 'e pesquisa pela placa' do 
    # Arrange
    user = User.create!(name: 'Maria', email: 'maria@sistemadefrete.com.br', password: '12345678')  
    sm = Sedex.create!(name:'Sedex', flat_fee: 50)
    Vehicle.delete_all
    Vehicle.create!(brand_name:'Ford', model:'Mustang', fabrication_year:'2020', full_capacity:100, license_plate:'ABC-1234', 
                    sedex_dez_id: sm.id, status:2)
    Vehicle.create!(brand_name:'Volkswagen', model:'Golf', fabrication_year:'2005', full_capacity:100, license_plate:'EFJ-1234', 
                    sedex_dez_id: sm.id, status:0)

    # Act
    login_as(user)
    visit root_path
    click_on 'Busca por veículo'
    fill_in 'Buscar veículo', with: 'EFJ'
    select "Em Manutenção", from: "status"
    click_on 'Buscar'
    
    # Assert
    expect(page).to have_content 'Volkswagen - Golf'
    expect(page).to have_content 'Em Manutenção'
    expect(page).not_to have_content 'Ford - Mustang'
  end
end