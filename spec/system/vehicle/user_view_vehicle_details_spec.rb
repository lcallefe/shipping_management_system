require 'rails_helper'

describe 'Usuário vê detalhes de veículo' do
  it 'a partir da tela de consulta de veículos' do
    
    # Arrange
    user = User.create!(name: 'Maria', email: 'maria@sistemadefrete.com.br', password: '12345678', admin:true)
    sm = Sedex.create!(name:'Sedex', flat_fee: 50)
    Vehicle.delete_all
    vehicle = Vehicle.create!(brand_name:'Renault', model:'Sedan', fabrication_year:'2001', full_capacity:100, license_plate:'EFJ-1234', 
                              sedex_id: sm.id, status:1)
                                   
  
    # Act
    login_as(user)
    visit vehicles_path
    click_on 'Ver detalhes'
 
    # Assert
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
    expect(page).to have_content 'Sedex'
    expect(page).to have_link('Sair', href: destroy_user_session_path)
    expect(current_path).to eq vehicle_path(vehicle.id)
  end
  it 'e volta para a tela inicial' do
    # Arrange
    user = User.create!(name: 'Maria', email: 'maria@sistemadefrete.com.br', password: '12345678', admin:true)
    sm = Sedex.create!(name:'Sedex', flat_fee: 50)
    Vehicle.delete_all
    vehicle = Vehicle.create!(brand_name:'Renault', model:'Sedan', fabrication_year:'2001', full_capacity:100, license_plate:'EFJ-1234', 
                              sedex_id: sm.id, status:1)
    
    # Act
    login_as(user)
    visit root_path
    click_on 'Busca por veículo'
    fill_in 'Buscar veículo', with: 'EFJ'
    click_on 'Buscar'
    click_on 'Ver detalhes'
    click_on 'Voltar'
    click_on 'Voltar'
 
    # Assert
    expect(page).not_to have_content 'Salvar'
    expect(page).not_to have_content 'Renault'
    expect(current_path).to eq root_path
  end
end